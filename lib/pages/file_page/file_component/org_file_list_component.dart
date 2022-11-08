import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:smh_flutter_sdk/utils/extension_utils.dart';

import '../../../config/colours.dart';
import '../../../widgets/list_item/file_list_item.dart';
import 'org_file_list_component_controller.dart';

class OrgFileListComponent extends GetView<OrgFileListComponentController> {
  @override
  Widget build(BuildContext context) {
    final state = controller.state;
    return GetBuilder(
      builder: (_) {
        return Scaffold(
            floatingActionButton: TextButton(
                onPressed: () {
                  controller.upload(
                    path: '',
                    context: context,
                    spaceId: controller.spaceId,
                  );
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

                        var org = state.organizations[index - 1];
                        return GestureDetector(
                          child: Container(
                            color: Colours.backgroundColor,
                            padding: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 12),
                            child: Flex(
                              direction: Axis.horizontal,
                              children: [
                                Expanded(
                                    flex: 0,
                                    child: Image(
                                        height: 44,
                                        width: 44,
                                        image: AssetImage(
                                            'assets/images/orgicon.png'))),
                                Expanded(
                                    flex: 1,
                                    child: Container(
                                      child: Text(
                                        org.name,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      padding:
                                          EdgeInsets.only(left: 8, right: 16),
                                    ))
                              ],
                            ),
                          ),
                          onTap: () {
                            controller.toTeamDetail(org);
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
                            content.fileType ?? content.type,
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
            ));
      },
      init: controller,
    );
  }
}
