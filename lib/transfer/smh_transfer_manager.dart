import 'dart:io';

import 'package:smh_flutter_sdk/apis/file_apis/smh_api_transfer_apis.dart';
import 'package:smh_flutter_sdk/core/task/base/smh_task.dart';
import 'package:smh_flutter_sdk/core/task/smh_download_task.dart';
import 'package:smh_flutter_sdk/core/task/smh_upload_task.dart';
import 'package:smh_flutter_sdk/model/api_model/s_m_h_upload_fiile_result_entity.dart';
import 'package:smh_flutter_sdk/model/user_model/smh_base_entity.dart';

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smh_flutter_sdk_example/transfer/smh_download_transfer.dart';
import 'package:smh_flutter_sdk_example/transfer/smh_upload_transfer.dart';

import '../smh_utils/fileicon_utils.dart';

class SMHTransferManager {
  static final SMHTransferManager manager = SMHTransferManager._internal();
  factory SMHTransferManager() {
    return manager;
  }
  SMHTransferManager._internal() {
    init();
  }

  final uploadingTaskList = <SMHUploadTransfer>[].obs;
  final uploadedTaskList = <SMHUploadTransfer>[].obs;
  final downloadingTaskList = <SMHDownloadTransfer>[].obs;
  final downloadedTaskList = <SMHDownloadTransfer>[].obs;

  final downloadIsPause = false.obs;
  final uploadIsPause = false.obs;

  void init() {}

  /// 上传文件
  upload({
    required String fileName,
    required String filePath,
    required dynamic body,
    required String userId,
    required String userToken,
    required String orgId,
    required String libraryId,
    required String spaceId,
    String? spaceOrgId,
  }) async {
    late SMHUploadTask task;
    SMHUploadTransfer transfer = SMHUploadTransfer();
    transfer.fileType = FileIconUtils.getFileType(fileName);
    task = await SMHApiTransferApis.upload(
      libraryId: libraryId,
      spaceId: spaceId,
      userId: userId,
      body: body,
      filePath: filePath,
      userToken: userToken,
      orgId: orgId,
      confirmKeyCalBack: (confirmKey) {
        task.info.confirmKey = confirmKey;
      },
      onSendProgress: (count, total) {
        transfer.progress.value = count;
      },
      finishCalBack: (result, error) {
        transfer.error = error;
        print(result.runtimeType);
        if (error == null) {
          transfer.response = result as SMHResponse<SMHUploadFileResultEntity>?;
          if (body is File) {
            body.delete();
          }
          if (body is String) {
            File(body).delete();
          }

          transfer.progress.value = transfer.totalLength;
          uploadedTaskList.add(transfer);
          uploadingTaskList.remove(transfer);
        }
      },
    );
    transfer.subScription = task.stateStream.stream.listen((event) {
      transfer.taskState.value = event;

      bool hasPause = false;
      for (SMHUploadTransfer transfer in uploadingTaskList) {
        if (transfer.taskState.value != SMHTaskState.processing &&
            transfer.taskState.value != SMHTaskState.waiting) {
          hasPause = true;
          break;
        }
      }
      uploadIsPause.value = hasPause;
      if (event == SMHTaskState.success || event == SMHTaskState.canceled) {
        transfer.subScription!.cancel();
      }

      if (event == SMHTaskState.processing) {
        transfer.startListeningSpeed();
      } else {
        transfer.endListeningSpeed();
      }
    });
    transfer.name = fileName;
    transfer.task = task;
    transfer.totalLength = task.info.length;

    uploadingTaskList.add(transfer);
  }

  /// 暂停所有上传任务
  pauseAllUploadTask() {
    for (SMHUploadTransfer transfer in uploadingTaskList) {
      transfer.task.pause();
    }
  }

  /// 暂停一个上传任务
  pauseUploadTask(SMHUploadTransfer transfer) {
    transfer.task.pause();
  }

  /// 继续所有上传任务
  resumeAllUploadTask() {
    for (SMHUploadTransfer transfer in uploadingTaskList) {
      transfer.task.resume();
    }
  }

  /// 继续一个上传任务
  resumeUploadTask(SMHUploadTransfer transfer) {
    transfer.task.resume();
  }

  /// 删除所有上传中任务
  deleteUploadingTasks() {
    for (SMHUploadTransfer transfer in uploadingTaskList) {
      transfer.task.cancel();
    }
    uploadingTaskList.clear();
  }

  /// 删除所有上传完成任务
  deleteUploadedTasks() {
    uploadedTaskList.clear();
  }

  /// 删除一个上传中的任务
  deleteUploadingTask(SMHUploadTransfer transfer) {
    transfer.task.cancel();
    uploadingTaskList.remove(transfer);
  }

  /// 删除一个上传完成的任务
  deleteUploadedTask(SMHUploadTransfer transfer) {
    uploadedTaskList.remove(transfer);
  }

  /// 下载一个文件
  download({
    required String fileName,
    required String filePath,
    required int fileSize,
    required String userId,
    required String userToken,
    required String orgId,
    required String libraryId,
    required String spaceId,
    String? spaceOrgId,
  }) async {
    final Directory tmpDir = await getApplicationDocumentsDirectory();
    String localPath = tmpDir.path + '/' + fileName;
    if (File(localPath).existsSync() == true) {
      File(localPath).deleteSync();
    }

    late SMHDownloadTask task;
    SMHDownloadTransfer transfer = SMHDownloadTransfer();
    transfer.fileType = FileIconUtils.getFileType(fileName);
    task = await SMHApiTransferApis.download(
      libraryId: libraryId,
      spaceId: spaceId,
      userId: userId,
      filePath: filePath,
      localPath: localPath,
      userToken: userToken,
      orgId: orgId,
      onReceiveProgress: (count, total) {
        if (transfer.totalLength == 0) {
          transfer.totalLength = total;
        }
        transfer.progress.value = count;
      },
      finishCalBack: (result, error) {
        if (error?.statusCode == 416) {
          print(error!.toJson().toString());
        }
        transfer.error = error;
        transfer.response = result as SMHResponse<Map<String, dynamic>>?;
        if (error == null) {
          transfer.progress.value = transfer.totalLength;
          downloadedTaskList.add(transfer);
          downloadingTaskList.remove(transfer);
        }
      },
    );

    transfer.subScription = task.stateStream.stream.listen((event) {
      transfer.taskState.value = event;
      bool hasPause = false;
      for (SMHDownloadTransfer transfer in downloadingTaskList) {
        if (transfer.taskState.value != SMHTaskState.processing &&
            transfer.taskState.value != SMHTaskState.waiting) {
          hasPause = true;
          break;
        }
      }
      downloadIsPause.value = hasPause;
      if (event == SMHTaskState.success || event == SMHTaskState.canceled) {
        transfer.subScription!.cancel();
      }

      if (event == SMHTaskState.processing) {
        transfer.startListeningSpeed();
      } else {
        transfer.endListeningSpeed();
      }
    });
    transfer.totalLength = fileSize;
    transfer.name = fileName;
    transfer.task = task;
    downloadingTaskList.add(transfer);
  }

  /// 暂停所有的下载任务
  pauseAllDownloadTask() {
    for (SMHDownloadTransfer transfer in manager.downloadingTaskList) {
      transfer.task.pause();
    }
  }

  /// 暂停一个下载任务
  pauseDownloadTask(SMHDownloadTransfer transfer) {
    transfer.task.pause();
  }

  /// 继续所有下载任务
  resumeAllDownloadTask() {
    for (SMHDownloadTransfer transfer in manager.downloadingTaskList) {
      transfer.task.resume();
    }
  }

  /// 继续一个下载任务
  resumeDownloadTask(SMHDownloadTransfer transfer) {
    transfer.task.resume();
  }

  /// 删除所有下载任务
  deleteDownloadingTasks() {
    for (SMHDownloadTransfer transfer in manager.downloadingTaskList) {
      transfer.task.cancel();
    }
    manager.downloadingTaskList.clear();
  }

  deleteDownloadingTask(SMHDownloadTransfer transfer) {
    transfer.task.cancel();
    manager.downloadedTaskList.remove(transfer);
  }

  /// 删除所有下载任务
  deleteDownloadedTasks() {
    manager.downloadedTaskList.clear();
  }

  /// 删除一个下载完成的任务
  deleteDownloadedTask(SMHDownloadTransfer transfer) {
    manager.downloadedTaskList.remove(transfer);
  }
}
