import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smh_flutter_sdk/model/user_model/s_m_h_favorite_file_list_entity.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../../models/user.dart';
import '../../transfer/smh_transfer_manager.dart';
import '../../widgets/file_menu.dart';
import '../../widgets/smh_upload_menu.dart';

mixin FileOption {
  clickFileMenu(SMHFileListContent content) async {
    Get.bottomSheet(SMHFileMenu(
      content,
      finishCallBack: () {
        Get.close(1);
      },
    ));
  }

  upload({
    required String path,
    required BuildContext context,
    String? spaceId,
    String? libraryId,
    String? spaceOrgId,
  }) {
    Get.bottomSheet(SMHUploadMenu(callBack: (result) {
      Get.close(1);
      if (result == UploadType.uploadImage) {
        _uploadImage(
          path: path,
          context: context,
          spaceId: spaceId,
          libraryId: libraryId,
          spaceOrgId: spaceOrgId,
        );
      }
      if (result == UploadType.uploadFile) {
        _uploadFile(
          path: path,
          context: context,
          spaceId: spaceId,
          libraryId: libraryId,
          spaceOrgId: spaceOrgId,
        );
      }

      if (result == UploadType.uploadCamera) {
        _uploadCamera(
          path: path,
          context: context,
          spaceId: spaceId,
          libraryId: libraryId,
          spaceOrgId: spaceOrgId,
        );
      }
      if (result == UploadType.uploadVideo) {
        _uploadVideo(
          path: path,
          context: context,
          spaceId: spaceId,
          libraryId: libraryId,
          spaceOrgId: spaceOrgId,
        );
      }

      if (result == UploadType.createDir) {
        _createDir(
          path: path,
          context: context,
          spaceId: spaceId,
          libraryId: libraryId,
          spaceOrgId: spaceOrgId,
        );
      }
    }));
  }

  _uploadImage({
    required String path,
    required BuildContext context,
    String? spaceId,
    String? libraryId,
    String? spaceOrgId,
  }) async {
    final List<AssetEntity>? entitys = await AssetPicker.pickAssets(context);
    if (entitys == null) return;
    //遍历
    for (var entity in entitys) {
      File? imgFile = await entity.file;

      SMHTransferManager.manager.upload(
          libraryId: libraryId ?? User().libraryId!,
          spaceId: spaceId ?? User().spaceId!,
          userId: User().userId!,
          body: imgFile,
          fileName: entity.title!,
          filePath: path + '/' + entity.title!,
          userToken: User().userToken!,
          orgId: User().organizationId!);
    }
  }

  _uploadCamera({
    required String path,
    required BuildContext context,
    String? spaceId,
    String? libraryId,
    String? spaceOrgId,
  }) {}

  _uploadFile({
    required String path,
    required BuildContext context,
    String? spaceId,
    String? libraryId,
    String? spaceOrgId,
  }) async {
    FilePickerResult? res = await FilePicker.platform.pickFiles();
    if (res?.files.length == 0) return;
    Directory docPath = await getApplicationDocumentsDirectory();
    for (var entity in res?.files ?? []) {
      String newPath = docPath.path + '/' + entity.name;
      await File(entity.path!).copy(newPath);
      File(entity.path!).delete();
      SMHTransferManager.manager.upload(
          libraryId: libraryId ?? User().libraryId!,
          spaceId: spaceId ?? User().spaceId!,
          userId: User().userId!,
          body: newPath,
          fileName: entity.name,
          filePath: path + '/' + entity.name,
          userToken: User().userToken!,
          orgId: User().organizationId!);
    }
  }

  _uploadVideo({
    required String path,
    required BuildContext context,
    String? spaceId,
    String? libraryId,
    String? spaceOrgId,
  }) {}

  _createDir({
    required String path,
    required BuildContext context,
    String? spaceId,
    String? libraryId,
    String? spaceOrgId,
  }) {}
}
