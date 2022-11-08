import 'package:get/get.dart';

import '../file_page/file_component/file_list_component_controller.dart';
import '../file_page/file_component/org_file_list_component_controller.dart';
import '../mine_page/mine_controller.dart';
import '../transfer/download_list_component_controller.dart';
import '../transfer/upload_list_component_controller.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MineController());
    Get.lazyPut(() => OrgFileListComponentController());
    Get.lazyPut(() => FileListComponentController());
    Get.lazyPut(() => UploadListComponentController());
    Get.lazyPut(() => DownloadListComponentController());
  }
}
