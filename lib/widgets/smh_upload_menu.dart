import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/colours.dart';

enum UploadType {
  uploadImage,
  uploadVideo,
  uploadCamera,
  uploadFile,
  createDir,
}

class SMHUploadMenu extends StatelessWidget {
  List<Map<String, dynamic>> uploadTypes = [
    {
      'type': UploadType.uploadImage,
      'name': '上传图片',
      'icon': 'assets/images/upload/upload_image.png'
    },
    // {
    //   'type': UploadType.uploadVideo,
    //   'name': '上传视频',
    //   'icon': 'assets/images/upload/upload_video.png'
    // },
    // {
    //   'type': UploadType.uploadCamera,
    //   'name': '拍照上传',
    //   'icon': 'assets/images/upload/upload_take_phone.png'
    // },
    {
      'type': UploadType.uploadFile,
      'name': '上传文件',
      'icon': 'assets/images/upload/upload_file.png'
    },
    // {
    //   'type': UploadType.createDir,
    //   'name': '新建文件夹',
    //   'icon': 'assets/images/upload/create_dir.png'
    // }
  ];
  Function(UploadType result) callBack;
  SMHUploadMenu({
    required this.callBack,
  });
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 320,
      width: Get.width,
      padding: EdgeInsets.only(top: 32),
      color: Colours.backgroundColorF5,
      child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, childAspectRatio: 1.0),
          children: uploadTypes
              .map((e) => GestureDetector(
                    child: uploadMenuItem(e['name']!, e['icon']!),
                    onTap: () {
                      callBack(e['type']!);
                    },
                  ))
              .toList()),
    );
  }

  Widget uploadMenuItem(String name, String icon) {
    return Container(
        child: Flex(
      direction: Axis.vertical,
      children: [
        Expanded(
            child: Image.asset(
          icon,
          width: 44,
          height: 44,
        )),
        Expanded(child: Text(name))
      ],
    ));
  }
}
