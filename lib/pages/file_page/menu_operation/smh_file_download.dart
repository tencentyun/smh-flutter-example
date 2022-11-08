import 'package:permission_handler/permission_handler.dart';
import 'package:smh_flutter_sdk/model/user_model/s_m_h_favorite_file_list_entity.dart';
import 'package:smh_flutter_sdk_example/pages/file_page/menu_operation/smh_file_operation.dart';

import '../../../models/user.dart';
import '../../../smh_utils/smh_toast.dart';
import '../../../transfer/smh_transfer_manager.dart';

class SMHFileDownload extends SMHFileOperation {
  SMHFileDownload() : super('下载', 'assets/images/menu/icon_menu_download.png');
  @override
  Future handler(List<SMHFileListContent> contents) async {
    var status = await Permission.manageExternalStorage.status;
    // if (status != PermissionStatus.granted) {
    //   //未授权则发起一次申请
    //   status = await Permission.manageExternalStorage.request();
    //   if (status != PermissionStatus.granted) {
    //     return false;
    //   }
    // }

    for (SMHFileListContent content in contents) {
      SMHTransferManager.manager.download(
          fileName: content.name!,
          filePath: content.path!.join('/'),
          fileSize: int.parse(content.size ?? '0'),
          userId: User().userId!,
          userToken: User().userToken!,
          orgId: User().organizationId!,
          libraryId: User().libraryId!,
          spaceId: content.spaceId!);
    }
    SMHToast.showMsg(msg: '${contents.length}个文件已加入下载列表');
    return null;
  }
}
