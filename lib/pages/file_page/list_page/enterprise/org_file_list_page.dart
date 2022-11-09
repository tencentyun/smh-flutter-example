import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:smh_flutter_sdk/model/enum/smh_string_enum.dart';
import 'package:smh_flutter_sdk/utils/extension_utils.dart';

import '../../../../config/colours.dart';
import '../../../../widgets/list_item/file_list_item.dart';
import 'org_file_list_controller.dart';

class OrgFileListPage extends GetView<OrgFileListController> {
  final String? tag;
  OrgFileListPage({this.tag});

  @override
  OrgFileListController get controller {
    return Get.find<OrgFileListController>(tag: tag);
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
                spaceId: controller.team!.spaceId!,
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
              child: CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        if (index == 0) {
                          return GestureDetector(
                            child: Container(
                              padding: EdgeInsets.only(left: 16),
                              alignment: Alignment.centerLeft,
                              height: 38,
                              color: Colours.backgroundColor,
                              child: Text(
                                  state.closeOrg == true ? '展开部门' : '收起部门'),
                            ),
                            onTap: controller.closeAndOpenOrg,
                          );
                        }

                        var team = state.organizations[index - 1];
                        return GestureDetector(
                          child: Container(
                            color: Colours.backgroundColor,
                            padding: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 12),
                            child: Row(
                              children: [
                                Image(
                                    height: 44,
                                    width: 44,
                                    image: AssetImage(
                                        'assets/images/orgicon.png')),
                                Container(
                                  child: Text(
                                    team.name ?? '',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  padding: EdgeInsets.only(left: 8, right: 16),
                                )
                              ],
                            ),
                          ),
                          onTap: () {
                            controller.toTeamDetail(team);
                          },
                        );
                      },
                      childCount: state.organizations.length == 0
                          ? 0
                          : state.closeOrg == true
                              ? 1
                              : state.organizations.length + 1,
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  SliverFixedExtentList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        var content = state.contens[index];
                        return GestureDetector(
                          child: FileListItem(
                            content.name,
                            content.modificationTime.toString() +
                                (content.size != null
                                    ? '  ' +
                                        int.parse(content.size ?? '0')
                                            .sizeFormart()
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
                      childCount: state.contens.length,
                    ),
                    itemExtent: 80,
                  )
                ],
              ),
            );
          },
          init: controller,
        ));
  }
}
