import 'package:get/get.dart';
import 'package:smh_flutter_sdk/core/task/base/smh_task.dart';

import '../../transfer/smh_download_transfer.dart';
import '../../transfer/smh_transfer_manager.dart';

class DownloadListComponentController extends GetxController {
  final SMHTransferManager manager = SMHTransferManager.manager;

  @override
  void onReady() {
    super.onReady();
  }

  void pauseOrResumeTask(SMHDownloadTransfer transfer) {
    if (transfer.taskState.value == SMHTaskState.processing ||
        transfer.taskState.value == SMHTaskState.waiting) {
      manager.pauseDownloadTask(transfer);
    } else {
      manager.resumeDownloadTask(transfer);
    }
  }

  void pauseOrResume() {
    if (manager.downloadIsPause.value == true) {
      manager.resumeAllDownloadTask();
    } else {
      manager.pauseAllDownloadTask();
    }
  }
}
