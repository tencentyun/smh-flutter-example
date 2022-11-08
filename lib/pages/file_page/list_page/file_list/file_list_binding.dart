import 'package:get/get.dart';

import 'file_list_controller.dart';

class FileListBinding extends Bindings {
  FileListBinding({this.tag});
  String? tag;
  @override
  void dependencies() {
    Get.lazyPut(
      () => FileListController(),
      tag: tag,
    );
  }
}
