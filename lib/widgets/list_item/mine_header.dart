import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/colours.dart';
import '../../models/user.dart';
import '../../pages/mine_page/mine_controller.dart';

class MineHeaderWidget extends StatelessWidget {
  MineHeaderWidget(
      {Key? key,
      this.color = Colors.white,
      this.width = 0,
      this.height = 0,
      this.clickPersonInfo,
      this.clickChangeOrg,
      this.clickUserIcon})
      : super(key: key);

  final double width;
  final double height;
  final Color color;
  final VoidCallback? clickPersonInfo;
  final VoidCallback? clickChangeOrg;
  final VoidCallback? clickUserIcon;

  @override
  Widget build(BuildContext context) {
    final state = Get.find<MineController>().state;
    // TODO: implement build
    return Container(
      padding: EdgeInsets.only(top: 80, left: 16, right: 16, bottom: 24),
      color: Colours.backgroundColor,
      child: Column(
        children: [
          Container(
            child: Column(
              children: [
                Flex(
                  direction: Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 0,
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              NetworkImage('http:' + User.currentUser.avatar!),
                        )),
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(top: 6, left: 16, right: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${User.currentUser.nickName}",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(height: 1.8, fontSize: 16),
                            ),
                            Text(
                              "有效期：${User.currentUser.expireTime}",
                              style: TextStyle(color: Colors.black45),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 0,
                        child: Container(
                            height: 80,
                            alignment: Alignment.centerRight,
                            child: Image(
                              width: 24,
                              image:
                                  AssetImage("assets/images/arrow_right.png"),
                            )))
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 24),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "容量",
                        style:
                            TextStyle(fontSize: 12, color: Colours.textColor60),
                      ),
                      Obx(() => Text(
                            "已使用：${state.spaceEntity.value.size}",
                            style: TextStyle(
                                fontSize: 12, color: Colours.textColor60),
                          ))
                    ],
                  ),
                ),
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.black12),
                    margin: EdgeInsets.only(top: 8),
                    width: width - 128,
                    height: 6,
                    child: UnconstrainedBox(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        height: 6,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: Colors.blue,
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
