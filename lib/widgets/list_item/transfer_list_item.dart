import 'package:flutter/material.dart';

import '../../config/colours.dart';
import '../../config/styles.dart';
import '../../smh_utils/fileicon_utils.dart';

class TransferListItem extends StatelessWidget {
  String title;
  String subTitle;
  String fileIcon;
  String? actionIcon;
  GestureTapCallback? actionCallback;
  double? progress;

  TransferListItem({
    required this.title,
    required this.subTitle,
    required this.fileIcon,
    this.actionIcon,
    this.actionCallback,
    this.progress,
  });
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
                    Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.listTitle,
                    ),
                    progress != null
                        ? LinearProgressIndicator(
                            value: progress,
                            backgroundColor: Colours.backgroundColorF5,
                            color: Colours.themeColor,
                          )
                        : Container(),
                    Wrap(
                      children: [
                        Text(
                          subTitle,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyles.listSubTitle,
                        ),
                      ],
                    )
                  ],
                ),
              )),
          Expanded(
              flex: 0,
              child: actionIcon != null
                  ? GestureDetector(
                      onTap: () {
                        actionCallback!();
                      },
                      child: Image(
                          height: 30,
                          width: 30,
                          image: AssetImage(actionIcon!)),
                    )
                  : Container())
        ],
      ),
    );
  }
}
