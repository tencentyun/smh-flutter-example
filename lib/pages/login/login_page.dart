import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../config/colours.dart';
import '../../config/constant.dart';
import '../../config/styles.dart';
import 'login_controller.dart';
import 'login_state.dart';

class LoginPage extends GetView<LoginController> {
  final phoneEditController = TextEditingController();
  final codeEditController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    LoginState state = controller.state;
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text(""),
        ),
        body: Obx(
          () => Container(
            color: Colors.white,
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                    alignment: AlignmentDirectional.centerStart,
                    margin: EdgeInsets.only(bottom: 24),
                    child: Text(
                      '使用手机号码登录',
                      style: TextStyles.bigBoldTitle,
                    )),
                Flex(
                  direction: Axis.horizontal,
                  children: [
                    Expanded(
                        flex: 0,
                        child: Container(
                          width: 70,
                          height: 44,
                          alignment: Alignment.center,
                          child: Text(
                            "+86",
                            style: TextStyle(color: Colours.textColor90),
                          ),
                        )),
                    Expanded(
                      flex: 0,
                      child: Container(
                        color: Colours.backgroundColorEEE,
                        height: 16,
                        width: 1,
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.only(left: 8, right: 8),
                          margin: EdgeInsets.only(left: 12),
                          height: 44,
                          child: TextField(
                            enableInteractiveSelection: false,
                            maxLines: 1,
                            controller: phoneEditController,
                            cursorColor: Colours.themeColor,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter(RegExp("[0-9]"),
                                  allow: true)
                            ],
                            decoration: InputDecoration(
                                hintStyle:
                                    TextStyle(color: Colours.textColor30),
                                suffixIcon: phoneEditController.text.length > 0
                                    ? IconButton(
                                        disabledColor: Colours.textColor60,
                                        color: Colours.textColor60,
                                        alignment: Alignment.center,
                                        icon: Icon(Icons.close_rounded),
                                        iconSize: 20,
                                        onPressed: () {
                                          phoneEditController.clear();
                                          state.phone.value = '';
                                        },
                                      )
                                    : null,
                                border: InputBorder.none,
                                hintMaxLines: 1,
                                hintText: "请输入手机号"),
                            onChanged: (result) {
                              state.phone.value = result;
                            },
                          ),
                        )),
                  ],
                ),
                Divider(
                  height: 1,
                  color: Colours.lineColor,
                ),
                SizedBox(
                  height: 12,
                ),
                Flex(
                  direction: Axis.horizontal,
                  children: [
                    Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.only(left: 8, right: 8),
                          margin: EdgeInsets.only(
                            right: 12,
                          ),
                          height: 44,
                          child: TextField(
                            enableInteractiveSelection: false,
                            controller: codeEditController,
                            cursorColor: Colours.themeColor,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter(RegExp("[0-9]"),
                                  allow: true)
                            ],
                            decoration: InputDecoration(
                                suffixIcon: state.smsCode.value.length > 0
                                    ? IconButton(
                                        color: Colours.textColor60,
                                        iconSize: 20,
                                        icon: Icon(Icons.close_rounded),
                                        onPressed: () {
                                          codeEditController.clear();
                                          state.smsCode.value = '';
                                        },
                                      )
                                    : null,
                                hintStyle:
                                    TextStyle(color: Colours.textColor30),
                                border: InputBorder.none,
                                hintText: '请输入验证码'),
                            onChanged: (value) {
                              state.smsCode.value = value;
                            },
                          ),
                        )),
                    Expanded(
                        flex: 0,
                        child: Container(
                          color: Colours.backgroundColor,
                          width: 120,
                          height: 44,
                          child: TextButton(
                              onPressed: (state.phone.value.length == 0)
                                  ? null
                                  : () => controller.sendSMSCode(),
                              child: Text(
                                state.sendTime.value,
                                style: (state.phone.value.length == 0)
                                    ? TextStyles.textb30S15W400
                                    : TextStyles.textThemeS15W400,
                              )),
                        )),
                  ],
                ),
                Divider(
                  height: 1,
                  color: Colours.lineColor,
                ),
                SizedBox(
                  height: 48,
                ),
                Container(
                  height: 48,
                  child: TextButton(
                      onPressed: state.phone.value.length > 0 &&
                              state.smsCode.value.length > 0
                          ? () => controller.loginWithSmsCode()
                          : null,
                      style: ButtonStyles.nonePadding,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: state.phone.value.length > 0 &&
                                  state.smsCode.value.length > 0
                              ? Colours.themeColor
                              : Colours.disableColor,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          Constant.appLogin,
                          style: TextStyles.textBlackS18,
                        ),
                      )),
                )
              ],
            ),
          ),
        ));
  }
}
