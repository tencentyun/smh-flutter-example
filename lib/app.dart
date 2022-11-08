import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smh_flutter_sdk_example/pages/login/login_binding.dart';
import 'package:smh_flutter_sdk_example/pages/login/login_page.dart';
import 'package:smh_flutter_sdk_example/pages/root/root_binding.dart';
import 'package:smh_flutter_sdk_example/pages/root/root_page.dart';
import 'package:smh_flutter_sdk_example/routers/smh_pages.dart';

import 'models/user.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'Flutter Demo',
      getPages: SMHPages.pages,
      theme: ThemeData(
          primaryColor: Colors.black,
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(color: Colors.black87),
            color: Colors.white,
            elevation: 0,
            titleTextStyle: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18),
          ),
          scaffoldBackgroundColor: Color.fromRGBO(250, 250, 250, 1)),
      initialBinding:
          User.currentUser.isLogin == true ? RootBinding() : LoginBinding(),
      home: User.currentUser.isLogin == true ? RootPage() : LoginPage(),
    );
  }
}
