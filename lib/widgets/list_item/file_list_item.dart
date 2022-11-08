import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../config/colours.dart';
import '../../config/styles.dart';
import '../../smh_utils/fileicon_utils.dart';

class FileListItem extends StatelessWidget {
  String? title;
  String? subTitle;
  String? fileIcon;
  bool? isSync;
  GestureTapCallback? menuCallback;
  FileListItem(this.title, this.subTitle, this.fileIcon, {this.menuCallback});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 80,
      color: Colours.backgroundColor,
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
              flex: 0,
              child: Image(
                  height: 44,
                  width: 44,
                  image: AssetImage(FileIconUtils.getFileIcon(fileIcon)))),
          Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 210),
                          child: Text(
                            title ?? '',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyles.title,
                          ),
                        ),
                        isSync == true
                            ? Container(
                                height: 20,
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(right: 8, left: 8),
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                    color: Colours.orangeColor40,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                  '同步盘',
                                  style: TextStyle(
                                      color: Colours.orangeColor, fontSize: 12),
                                ),
                              )
                            : Text('')
                      ],
                    ),
                    Text(
                      subTitle ?? '',
                      style: TextStyles.subTitle,
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 0,
              child: GestureDetector(
                onTap: menuCallback,
                child: Image(
                    height: 30,
                    width: 30,
                    image: AssetImage('assets/images/nav/nav_more.png')),
              ))
        ],
      ),
    );
  }
}
