import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:smh_flutter_sdk/model/enum/smh_string_enum.dart';
import 'package:smh_flutter_sdk/model/user_model/s_m_h_favorite_file_list_entity.dart';
import 'package:smh_flutter_sdk/utils/extension_utils.dart';

import '../../../widgets/list_item/file_list_item.dart';
import 'file_list_component_controller.dart';

class FileListComponent extends GetView<FileListComponentController> {
  @override
  Widget build(BuildContext context) {
    final state = controller.state;
    return GetBuilder(
      builder: (_) {
        return Scaffold(
            floatingActionButton: TextButton(
                onPressed: () {
                  controller.upload(path: '', context: context);
                },
                child: Image(
                  image: AssetImage('assets/images/nav/float_add.png'),
                  width: 44,
                  height: 44,
                )),
            body: SmartRefresher(
              controller: controller.refreshController,
              enablePullDown: true,
              enablePullUp: true,
              onLoading: controller.loadMoreData,
              onRefresh: controller.loadNewData,
              header: ClassicHeader(),
              footer: ClassicFooter(),
              child: ListView.builder(
                itemExtent: 80,
                itemCount: state.contens.length,
                itemBuilder: (BuildContext context, int index) {
                  SMHFileListContent content = state.contens[index];
                  return GestureDetector(
                    child: FileListItem(
                      content.name,
                      content.modificationTime.toString() +
                          (content.size != null
                              ? '  ' +
                                  int.parse(content.size ?? '0').sizeFormart()
                              : ''),
                      content.fileType?.name ?? SMHFileType.dir.name,
                      menuCallback: () {
                        controller.clickFileMenu(content);
                      },
                    ),
                    onTap: () {
                      controller.toDirDetail(content);
                    },
                  );
                },
              ),
            ));
      },
      init: controller,
    );
  }
}
