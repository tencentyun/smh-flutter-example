import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:smh_flutter_sdk/apis/file_apis/smh_api_directory_apis.dart';
import 'package:smh_flutter_sdk/apis/file_apis/smh_api_usage_apis.dart';
import 'package:smh_flutter_sdk/core/error/smh_error.dart';
import 'package:smh_flutter_sdk/model/enum/smh_string_enum.dart';
import 'package:smh_flutter_sdk/model/user_model/s_m_h_favorite_file_list_entity.dart';
import 'package:smh_flutter_sdk/model/user_model/smh_base_entity.dart';
import '../../../models/user.dart';
import '../../../routers/smh_routes.dart';
import '../../../smh_utils/smh_toast.dart';
import '../list_page/file_list/file_list_binding.dart';
import '../list_page/file_list/file_list_page.dart';
import '../mixin_file_op.dart';
import 'file_list_component_state.dart';

class FileListComponentController extends GetxController with FileOption {
  int page = 1;
  int pageSize = 10;
  String? dirPath;
  final FileListComponentState state = FileListComponentState();

  late final RefreshController refreshController;
  FileListComponentController() {
    refreshController = RefreshController(initialRefresh: false);
  }

  @override
  void onReady() {
    super.onReady();
    loadNewData();
  }

  loadMoreData() async {
    SMHResponse<SMHFileListEntity>? smhResponse;
    try {
      smhResponse = await SMHAPIDirectoryApis.listDirectory(
          libraryId: User.currentUser.libraryId!,
          spaceId: User.currentUser.spaceId!,
          page: page,
          pageSize: pageSize,
          dirPath: dirPath ?? '');
    } on SMHError catch (e) {
      SMHToast.showError(error: e);
      refreshController.loadFailed();
      return;
    }
    if (smhResponse?.data?.contents?.length == 0) {
      refreshController.loadNoData();
    }
    page++;
    for (SMHFileListContent content in smhResponse!.data!.contents!) {
      content.spaceId = User.currentUser.spaceId;
      content.libraryId = User.currentUser.libraryId;
      state.contens.add(content);
    }
    refreshController.loadComplete();
    update();
  }

  loadNewData() async {
    page = 1;
    SMHResponse<SMHFileListEntity>? smhResponse;
    try {
      smhResponse = await SMHAPIDirectoryApis.listDirectory(
          libraryId: User.currentUser.libraryId!,
          spaceId: User.currentUser.spaceId!,
          page: page,
          pageSize: pageSize,
          dirPath: dirPath ?? '');
    } on SMHError catch (e) {
      SMHToast.showError(error: e);
      refreshController.refreshFailed();
      return;
    }

    page++;
    state.contens.clear();
    for (SMHFileListContent content in smhResponse!.data!.contents!) {
      content.spaceId = User.currentUser.spaceId;
      content.libraryId = User.currentUser.libraryId;
      state.contens.add(content);
    }
    refreshController.refreshCompleted();
    update();
  }

  toDirDetail(SMHFileListContent content) {
    if (content.type == SMHFileType.dir.name) {
      Get.to(() => FileListPage(tag: content.path?.join('_')),
          binding: FileListBinding(tag: content.path?.join('_')),
          arguments: {
            'content': content,
          });
    } else {
      Get.toNamed(SMHRoutes.FILE_PREVIEW, arguments: {'content': content});
    }
  }
}
