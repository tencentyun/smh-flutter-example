import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:smh_flutter_sdk/model/user_model/s_m_h_favorite_file_list_entity.dart';
import 'package:smh_flutter_sdk/utils/extension_utils.dart';

import '../../../../models/user.dart';
import '../../../../widgets/list_item/file_list_item.dart';
import 'file_list_controller.dart';

class FileListPage extends GetView<FileListController> {
  final String? tag;
  FileListPage({this.tag});

  @override
  FileListController get controller {
    return Get.find<FileListController>(tag: tag);
  }

  @override
  Widget build(BuildContext context) {
    final state = controller.state;
    return Scaffold(
        appBar: AppBar(
          title: Obx(() => Text(state.title.value)),
        ),
        floatingActionButton: TextButton(
            onPressed: () {
              controller.upload(
                context: context,
                path: controller.dirPath!,
                spaceId: controller.team?.spaceId ?? User.currentUser.spaceId!,
              );
            },
            child: Image(
              image: AssetImage('assets/images/nav/float_add.png'),
              width: 44,
              height: 44,
            )),
        body: GetBuilder(
          global: false,
          builder: (_) {
            return SmartRefresher(
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
                      content.fileType?.name ?? content.type?.name,
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
            );
          },
          init: controller,
        ));
  }
}
