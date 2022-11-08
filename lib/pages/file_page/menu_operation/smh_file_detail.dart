import 'package:smh_flutter_sdk/model/user_model/s_m_h_favorite_file_list_entity.dart';

import 'package:smh_flutter_sdk_example/pages/file_page/menu_operation/smh_file_operation.dart';

import '../../../smh_utils/smh_toast.dart';

class SMHFileDetail extends SMHFileOperation {
  SMHFileDetail() : super('详情', 'assets/images/menu/icon_menu_detail.png');
  @override
  Future handler(List<SMHFileListContent> contents) async {
    SMHFileListContent content = contents.first;
    SMHToast.showMsg(msg: content.toJson().toString());
    return null;
  }
}
