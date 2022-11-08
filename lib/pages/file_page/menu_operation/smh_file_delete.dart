import 'package:smh_flutter_sdk/apis/file_apis/smh_api_file_apis.dart';
import 'package:smh_flutter_sdk/core/error/smh_error.dart';
import 'package:smh_flutter_sdk/model/user_model/s_m_h_favorite_file_list_entity.dart';
import 'package:smh_flutter_sdk/model/user_model/smh_base_entity.dart';
import 'package:smh_flutter_sdk_example/pages/file_page/menu_operation/smh_file_operation.dart';

import '../../../models/user.dart';
import '../../../smh_utils/smh_toast.dart';

class SMHFileDelete extends SMHFileOperation {
  SMHFileDelete() : super('删除', 'assets/images/menu/icon_menu_delete.png');
  @override
  Future handler(List<SMHFileListContent> contents) async {
    SMHFileListContent content = contents.first;
    SMHResponse? response;
    try {
      response = await SMHAPIFileApis.deleteFile(
          libraryId: User().libraryId!,
          spaceId: User().spaceId!,
          filePath: content.path!.join('/'));
    } on SMHError catch (e) {
      SMHToast.showError(error: e);
      return;
    }
    SMHToast.showMsg(msg: '删除成功');
  }
}
