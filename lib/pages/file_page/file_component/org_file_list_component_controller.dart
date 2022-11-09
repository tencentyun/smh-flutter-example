import 'package:smh_flutter_sdk/apis/file_apis/smh_api_directory_apis.dart';
import 'package:smh_flutter_sdk/apis/user_apis/smh_user_team_apis.dart';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:smh_flutter_sdk/core/error/smh_error.dart';
import 'package:smh_flutter_sdk/model/enum/smh_string_enum.dart';
import 'package:smh_flutter_sdk/model/user_model/s_m_h_favorite_file_list_entity.dart';
import 'package:smh_flutter_sdk/model/user_model/s_m_h_team_info_entity.dart';
import 'package:smh_flutter_sdk/model/user_model/smh_base_entity.dart';
import 'package:smh_flutter_sdk_example/models/user.dart';
import 'package:smh_flutter_sdk_example/pages/file_page/mixin_file_op.dart';
import 'package:smh_flutter_sdk_example/smh_utils/smh_toast.dart';

import '../../../routers/smh_routes.dart';
import '../list_page/enterprise/org_file_list_binding.dart';
import '../list_page/enterprise/org_file_list_page.dart';
import '../list_page/file_list/file_list_binding.dart';
import '../list_page/file_list/file_list_page.dart';
import 'org_file_list_component_state.dart';

class OrgFileListComponentController extends GetxController with FileOption {
  int page = 1;
  int pageSize = 10;
  String? dirPath;
  String? orgId;
  String? spaceId;
  final OrgFileListComponentState state = OrgFileListComponentState();

  late final RefreshController refreshController;
  OrgFileListComponentController() {
    refreshController = RefreshController(initialRefresh: false);
  }

  @override
  void onReady() {
    super.onReady();
    loadNewData();
  }

  loadTeams() async {
    SMHResponse<SMHTeamInfoEntity>? smhResponse;
    try {
      smhResponse = await SMHUserTeamApis.getTeamDetailInfo(
          organizationId: User.currentUser.organizationId!,
          userToken: User.currentUser.userToken!,
          checkPermission: true);
    } on SMHError catch (e) {
      SMHToast.showError(error: e);
      return;
    }
    orgId = smhResponse?.data?.orgId.toString();
    spaceId = smhResponse?.data?.spaceId;
    state.organizations = smhResponse?.data?.children ?? [];
  }

  loadMoreData() async {
    SMHResponse<SMHFileListEntity>? smhResponse;
    try {
      smhResponse = await SMHAPIDirectoryApis.listDirectory(
          libraryId: User.currentUser.libraryId!,
          spaceId: spaceId ?? '',
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
      content.spaceId = spaceId;
      content.libraryId = User.currentUser.libraryId;
      state.contens.add(content);
    }
    refreshController.loadComplete();
    update();
  }

  closeAndOpenOrg() {
    state.closeOrg = !state.closeOrg;
    update();
  }

  loadNewData() async {
    page = 1;
    await loadTeams();
    SMHResponse<SMHFileListEntity>? smhResponse;
    try {
      smhResponse = await SMHAPIDirectoryApis.listDirectory(
          libraryId: User.currentUser.libraryId!,
          spaceId: spaceId ?? '',
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
      content.spaceId = spaceId;
      content.libraryId = User.currentUser.libraryId;
      state.contens.add(content);
    }
    refreshController.refreshCompleted();
    update();
  }

  toTeamDetail(SMHTeamInfoChildren team) {
    Get.to(
        () => OrgFileListPage(
            tag: team.parentId.toString() + team.name.toString()),
        binding: OrgFileListBinding(
            tag: team.parentId.toString() + team.name.toString()),
        arguments: {
          'team': team,
        });
  }

  toDirDetail(SMHFileListContent content) {
    SMHTeamInfoChildren team = SMHTeamInfoChildren();
    team.spaceId = spaceId;
    if (content.type?.name == SMHFileType.dir.name) {
      Get.to(() => FileListPage(tag: content.path?.join('_')),
          binding: FileListBinding(tag: content.path?.join('_')),
          arguments: {
            'content': content,
            'team': team,
          });
    } else {
      Get.toNamed(SMHRoutes.FILE_PREVIEW, arguments: {
        'content': content,
        'team': team,
      });
    }
  }
}
