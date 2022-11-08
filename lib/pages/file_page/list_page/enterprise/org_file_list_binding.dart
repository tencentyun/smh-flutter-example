import 'package:get/get.dart';

import 'org_file_list_controller.dart';

class OrgFileListBinding extends Bindings {
  OrgFileListBinding({this.tag});
  String? tag;
  @override
  void dependencies() {
    Get.lazyPut(
      () => OrgFileListController(),
      tag: tag,
    );
  }
}
