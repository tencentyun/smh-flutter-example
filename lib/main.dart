import 'dart:async';
import 'dart:io';

import 'package:smh_flutter_sdk/apis/file_apis/smh_api_usage_apis.dart';
import 'package:smh_flutter_sdk/beacon/smh_beacon_manager.dart';
import 'package:smh_flutter_sdk/core/base/smh_service.dart';
import 'package:smh_flutter_sdk/core/base/smh_services_manager.dart';
import 'package:smh_flutter_sdk/core/error/smh_error.dart';
import 'package:smh_flutter_sdk/core/services/smh_api_service.dart';
import 'package:smh_flutter_sdk/core/services/smh_user_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smh_flutter_sdk/model/enum/smh_string_enum.dart';
import 'package:smh_flutter_sdk/model/user_model/smh_base_entity.dart';
import 'package:smh_flutter_sdk_example/smh_utils/refresh_accesstoken.dart';

import 'app.dart';
import 'models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  configSMH();
  await User.currentUser.queryCache();
  await configBeacon();
  // 设置状态栏
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    // 顶部状态栏颜色
    statusBarColor: Colors.transparent,
    // 顶部状态栏图标的亮度
    statusBarIconBrightness: Brightness.dark,
    // 顶部状态栏的亮度
    statusBarBrightness:
        !kIsWeb && Platform.isAndroid ? Brightness.dark : Brightness.light,
    // 系统底部导航栏的颜
    systemNavigationBarColor: Colors.white,
    // 系统底部导航栏分割线颜色
    systemNavigationBarDividerColor: Colors.transparent,
    // 系统导航栏图标的亮度
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  // 设置设备方向
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) => runApp(MyApp()));
}

configSMH() {
  SMHServicesManager().registerService(SMHUserService());
  SMHAPIService apiService = SMHAPIService()
    ..setAccessTokenRefreshHandle(CustomRefreshAccessTokenHander());
  SMHServicesManager().registerService(apiService);

  SMHServicesManager().configHostWithEnv("host", SMHHostType.dev);

  SMHServicesManager().setupCurrentEnv(SMHHostType.dev);
}

configBeacon() async {
  if (User.currentUser.isLogin == true) {
    await SMHServicesManager().initBeaconSDK(
        userId: User().userId!,
        organizationId: User().organizationId!,
        isDebug: true);
  }
}
