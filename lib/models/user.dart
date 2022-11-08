import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class User {
  bool? isLogin;
  String? userId;
  String? userToken;
  String? accessToken;
  String? spaceId;
  String? libraryId;
  String? organizationId;
  String? organizationName;
  String? avatar;
  String? phone;
  String? nickName;
  String? role;
  String? expireTime;
  static final User currentUser = User._internal();
  User._internal() {
    init();
  }
  factory User() {
    return currentUser;
  }

  void init() {}

  queryCache() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? jsonString = sp.getString('currentUser');
    if (jsonString == null) {
      isLogin = false;
      return;
    }
    Map<String, dynamic> map = json.decode(jsonString);
    fromJson(map);
  }

  remove() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('currentUser');
    isLogin = false;
    userId = null;
    userToken = null;
    accessToken = null;
    spaceId = null;
    libraryId = null;
    organizationId = null;
    organizationName = null;
    avatar = null;
    phone = null;
    nickName = null;
    role = null;
    expireTime = null;
  }

  updateCache() {
    persistence();
  }

  persistence() async {
    String map = currentUser.toJson();
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('currentUser', map);
  }

  fromJson(Map<String, dynamic> map) {
    isLogin = map['isLogin'];
    userId = map['userId'];
    userToken = map['userToken'];
    accessToken = map['accessToken'];
    spaceId = map['spaceId'];
    libraryId = map['libraryId'];
    organizationId = map['organizationId'];
    organizationName = map['organizationName'];
    avatar = map['avatar'];
    phone = map['phone'];
    nickName = map['nickName'];
    role = map['role'];
    expireTime = map['expireTime'];
  }

  toJson() {
    Map<String, dynamic> map = {};
    map['isLogin'] = isLogin;
    map['userId'] = userId;
    map['userToken'] = userToken;
    map['accessToken'] = accessToken;
    map['spaceId'] = spaceId;
    map['libraryId'] = libraryId;
    map['organizationId'] = organizationId;
    map['organizationName'] = organizationName;
    map['avatar'] = avatar;
    map['phone'] = phone;
    map['nickName'] = nickName;
    map['role'] = role;
    map['expireTime'] = expireTime;
    return json.encode(map);
  }
}
