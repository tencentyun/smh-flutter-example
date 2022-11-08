import 'dart:ui';

class Constant {
  static const String appName = "腾讯云盘";
  static const String appSlogo = "距离虽远，合作无间";
  static const String appSlogoContent = "在线办公新方式，企业团队必备";
  static const String appLogin = "登录";
  static const String appMobileLogin = "手机号登录";
  static const String appWXLogin = "微信登录";
  static const String appAgreen = "我已阅读并同意";
  static const String appAgreenDetail =
      "《软件许可协议》《隐私保护协议》《儿童隐私保护协议》《第三方信息共享协议》《隐私保护指引摘要》";
}

final kwidth = window.physicalSize.width / window.devicePixelRatio;
final kheight = window.physicalSize.height / window.devicePixelRatio;
double hc_FitWidth(double width) {
  return kwidth / 375.0 * width;
}

double hc_FitHeight(double height) {
  return kheight / 667.0 * height;
}
