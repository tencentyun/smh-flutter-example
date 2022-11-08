import 'dart:async';

import 'package:get/get.dart';
import 'package:smh_flutter_sdk/core/error/smh_error.dart';
import 'package:smh_flutter_sdk/core/task/base/smh_task.dart';
import 'package:smh_flutter_sdk/model/enum/smh_string_enum.dart';

class SMHTransfer {
  /// 任务
  late SMHTask task;

  /// 文件总大小
  late int totalLength = 0;

  final progress = 0.obs;

  SMHError? error;

  /// 文件名
  late String name;

  late SMHFileType fileType;

  var taskState = SMHTaskState.waiting.obs;

  StreamSubscription<SMHTaskState>? subScription;

  @override
  void dispose() {
    if (subScription != null && !subScription!.isPaused) subScription!.cancel();
  }
}
