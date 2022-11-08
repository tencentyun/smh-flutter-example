import 'package:smh_flutter_sdk/core/task/base/smh_task.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smh_flutter_sdk/utils/extension_utils.dart';
import 'package:smh_flutter_sdk_example/pages/transfer/upload_list_component_controller.dart';

import '../../config/colours.dart';
import '../../widgets/list_item/transfer_list_item.dart';

class UploadListComponent extends GetView<UploadListComponentController> {
  @override
  Widget build(BuildContext context) {
    final manager = controller.manager;
    return Obx(() => CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  if (index == 0) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      height: 38,
                      child: Flex(
                        direction: Axis.horizontal,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 0,
                            child: Text(
                                '正在上传(${manager.uploadingTaskList.length.toString()})'),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(),
                          ),
                          Expanded(
                            flex: 0,
                            child: TextButton(
                              onPressed: () {
                                controller.pauseOrResume();
                              },
                              child: Obx(() => Text(
                                  manager.uploadIsPause.value == true
                                      ? '全部开始'
                                      : '全部暂停',
                                  style: TextStyle(
                                      color: Colours.themeColor,
                                      fontSize: 14))),
                            ),
                          ),
                          Expanded(
                            flex: 0,
                            child: TextButton(
                              onPressed: () {
                                manager.deleteUploadingTasks();
                              },
                              child: Text(
                                '全部删除',
                                style: TextStyle(
                                    color: Colours.themeColor, fontSize: 14),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }
                  var entity = manager.uploadingTaskList[index - 1];
                  return Obx(() => TransferListItem(
                        title: entity.response?.data?.name ?? entity.name,
                        subTitle: entity.taskState.value == SMHTaskState.error
                            ? (entity.error!.smhZhMessage ??
                                entity.error!.statusMessage ??
                                '')
                            : entity.taskState.value == SMHTaskState.pause
                                ? '已暂停'
                                : entity.taskState.value == SMHTaskState.waiting
                                    ? '等待中'
                                    : entity.totalLength.sizeFormart() +
                                        ' ' +
                                        entity.speed.value,
                        fileIcon: entity.fileType.name,
                        actionIcon: entity.taskState.value == SMHTaskState.error
                            ? 'assets/restartprocess.png'
                            : (entity.taskState.value ==
                                        SMHTaskState.processing ||
                                    entity.taskState.value ==
                                        SMHTaskState.waiting)
                                ? 'assets/pauseprocess.png'
                                : 'assets/startprocess.png',
                        progress: entity.progress.value *
                            1.0 /
                            entity.totalLength *
                            1.0,
                        actionCallback: () {
                          controller.pauseOrResumeTask(entity);
                        },
                      ));
                },
                childCount: manager.uploadingTaskList.length == 0
                    ? 0
                    : manager.uploadingTaskList.length + 1,
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  if (index == 0) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      height: 38,
                      child: Flex(
                        direction: Axis.horizontal,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 0,
                            child: Text(
                                '上传完成(${manager.uploadedTaskList.length.toString()})'),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(),
                          ),
                          Expanded(
                            flex: 0,
                            child: TextButton(
                              onPressed: () {
                                manager.deleteUploadedTasks();
                              },
                              child: Text(
                                '全部删除',
                                style: TextStyle(
                                    color: Colours.themeColor, fontSize: 14),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }

                  var entity = manager.uploadedTaskList[index - 1];
                  return TransferListItem(
                      title: entity.response!.data!.name!,
                      subTitle: entity.response!.data!.creationTime!,
                      fileIcon: entity.fileType.name);
                  ;
                },
                childCount: manager.uploadedTaskList.length == 0
                    ? 0
                    : manager.uploadedTaskList.length + 1,
              ),
            )
          ],
        ));
  }
}
