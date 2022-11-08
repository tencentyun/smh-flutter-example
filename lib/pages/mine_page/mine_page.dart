import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/colours.dart';
import '../../widgets/list_item/mine_header.dart';
import '../../widgets/list_item/mine_list_item.dart';
import 'mine_controller.dart';

final kwidth = window.physicalSize.width;
final kheight = window.physicalSize.height;

class MinePage extends GetView<MineController> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colours.backgroundColorF5,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            MineHeaderWidget(
              clickPersonInfo: () {},
              clickChangeOrg: () {},
              clickUserIcon: () {},
              width: kwidth,
              height: 180,
              color: Colors.white,
            ),
            Container(
              color: Colours.backgroundColorF5,
              height: 10,
            ),
            Container(
              color: Colours.backgroundColorF5,
              height: 10,
            ),
            Container(
              color: Colours.backgroundColor,
              height: 50,
              child: TextButton(
                  onPressed: () {
                    controller.logout();
                  },
                  child: Text(
                    '退出登录',
                    style: TextStyle(color: Colors.red, fontSize: 18),
                  )),
            )
          ],
        ));
  }
}
