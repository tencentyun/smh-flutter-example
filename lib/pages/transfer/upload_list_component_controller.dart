import 'package:smh_flutter_sdk/core/task/base/smh_task.dart';

import 'package:get/get.dart';

import '../../transfer/smh_transfer_manager.dart';
import '../../transfer/smh_upload_transfer.dart';

class UploadListComponentController extends GetxController {
  final SMHTransferManager manager = SMHTransferManager.manager;
  @override
  void onReady() {
    super.onReady();
  }

  void pauseOrResumeTask(SMHUploadTransfer transfer) {
    if (transfer.taskState.value == SMHTaskState.processing) {
      manager.pauseUploadTask(transfer);
    } else {
      manager.resumeUploadTask(transfer);
    }
  }

  void pauseOrResume() {
    if (manager.uploadIsPause.value == true) {
      manager.resumeAllUploadTask();
    } else {
      manager.pauseAllUploadTask();
    }
  }
}
