import 'package:smh_flutter_sdk/apis/file_apis/smh_api_file_apis.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smh_flutter_sdk/core/error/smh_error.dart';
import 'package:smh_flutter_sdk/model/api_model/s_m_h_file_download_url_entity.dart';
import 'package:smh_flutter_sdk/model/enum/smh_string_enum.dart';
import 'package:smh_flutter_sdk/model/user_model/s_m_h_favorite_file_list_entity.dart';
import 'package:smh_flutter_sdk/model/user_model/smh_base_entity.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../models/user.dart';
import '../../smh_utils/smh_toast.dart';

class SMHPreviewPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SMHPreviewPageState();
  }
}

class _SMHPreviewPageState extends State<SMHPreviewPage> {
  String? previewUrl;
  late SMHFileListContent content;

  @override
  void initState() {
    content = Get.arguments['content'];
    if (content.fileType?.name == SMHFileType.video.name) {
      _getDownloadUrl();
    } else {
      _getPreviewUrl();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(content.name.toString()),
      ),
      body: Container(
        width: Get.width,
        height: Get.height,
        child: WebView(
          key: Key(previewUrl ?? ''),
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: previewUrl,
        ),
      ),
    );
  }

  _getDownloadUrl() async {
    SMHResponse<SMHFileDownloadUrlEntity>? response;
    try {
      response = await SMHAPIFileApis.getDownloadUrl(
          libraryId: User.currentUser.libraryId!,
          spaceId: content.spaceId!,
          filePath: content.path!.join('/'));
    } on SMHError catch (e) {
      SMHToast.showError(error: e);
    }
    if (response != null) {
      setState(() {
        previewUrl = response!.data!.cosUrl;
      });
    }
  }

  _getPreviewUrl() async {
    SMHResponse? response;
    try {
      response = await SMHAPIFileApis.previewFileByHtml(
          libraryId: User.currentUser.libraryId!,
          spaceId: content.spaceId!,
          filePath: content.path!.join('/'));
    } on SMHError catch (e) {
      SMHToast.showError(error: e);
    }
    if (response != null) {
      setState(() {
        previewUrl = response!.data!['location'];
      });
    }
  }
}
