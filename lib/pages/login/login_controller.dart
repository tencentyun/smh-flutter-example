import 'dart:async';

import 'package:smh_flutter_sdk/apis/user_apis/smh_user_login_apis.dart';
import 'package:smh_flutter_sdk/apis/user_apis/smh_user_organization_apis.dart';
import 'package:get/get.dart';
import 'package:smh_flutter_sdk/apis/user_apis/smh_user_space_apis.dart';
import 'package:smh_flutter_sdk/core/error/smh_error.dart';
import 'package:smh_flutter_sdk/model/user_model/s_m_h_access_token_entity.dart';
import 'package:smh_flutter_sdk/model/user_model/smh_base_entity.dart';
import 'package:smh_flutter_sdk/model/user_model/smh_organization_info.dart';
import 'package:smh_flutter_sdk_example/pages/login/select_organization_page.dart';
import '../../models/user.dart';
import '../../routers/smh_routes.dart';
import '../../smh_utils/smh_toast.dart';
import 'login_state.dart';

class LoginController extends GetxController {
  final LoginState state = LoginState();
  Timer? timer;
  LoginController() {
    state.sendTime.value = '发送验证码';
  }
  loginWithSmsCode() async {
    if (state.smsCode.value.length == 0) {
      SMHToast.showMsg(msg: '请输入验证码');
      return;
    }
    SMHResponse<SMHOrganizationInfoEntity>? response;
    try {
      response = await SMHUserLoginApis.smsCodeLogin(
        phoneNumber: state.phone.value,
        code: state.smsCode.value,
        countryCode: state.countryCode.value,
      );
    } on SMHError catch (e) {
      SMHToast.showError(error: e);
      return;
    }

    if (response == null || response.data == null) {
      SMHToast.showMsg(msg: '获取登录信息失败');
      return;
    }

    List<SMHOrganizationInfoOrganizations>? organizations =
        response.data?.organizations;
    if (organizations == null || organizations.length == 0) {
      SMHToast.showMsg(msg: '当前账号未加入任何组织');
      return;
    }

    SMHOrganizationInfoOrganizations selectOrg =
        await _selectOrganization(organizations);
    try {
      SMHUserOrganizationApis.loginOrganization(
          organizationId: selectOrg.id!.toString(),
          userToken: response.data!.userToken!);
    } catch (_) {}

    User.currentUser.userId = response.data!.userId!;
    User.currentUser.userToken = response.data!.userToken!;
    User.currentUser.organizationId = selectOrg.id.toString();
    User.currentUser.libraryId = selectOrg.libraryId.toString();
    User.currentUser.organizationId = selectOrg.id.toString();
    User.currentUser.nickName = selectOrg.orgUser!.nickname!;
    User.currentUser.phone = state.phone.value;
    User.currentUser.organizationName = selectOrg.name;
    User.currentUser.role = selectOrg.orgUser!.role!.name;
    User.currentUser.avatar = selectOrg.orgUser!.avatar!;
    SMHResponse<SMHAccessTokenEntity>? smhResponse;
    try {
      smhResponse = await SMHUserSpaceApis.getUserInfoAndAccessToken(
          organizationId: User.currentUser.organizationId!,
          userToken: User.currentUser.userToken!);
    } on SMHError catch (e) {
      SMHToast.showError(error: e);
      return;
    }

    User.currentUser.accessToken = smhResponse!.data!.accessToken!;
    User.currentUser.spaceId = smhResponse.data!.spaceId!;
    User.currentUser.isLogin = true;
    User.currentUser.expireTime = selectOrg.extensionData!.expireTime!;
    User.currentUser.updateCache();
    Get.offAllNamed(SMHRoutes.ROOT);
  }

  sendSMSCode() async {
    if (state.isSend.value == true) {
      return;
    }
    if (state.phone.value.isEmpty) {
      SMHToast.showMsg(msg: '请输入手机号');
      return;
    }

    SMHResponse? response;
    try {
      response = await SMHUserLoginApis.sendSmsCode(
          phoneNumber: state.phone.value, countryCode: state.countryCode.value);
    } on SMHError catch (e) {
      SMHToast.showError(error: e);
      return;
    }
    state.isSend.value = true;
    if (response != null) {
      _startTime();
    }
  }

  Future<SMHOrganizationInfoOrganizations> _selectOrganization(
      List<SMHOrganizationInfoOrganizations> organizations) async {
    SMHOrganizationInfoOrganizations selectOrg;
    if (organizations.length > 1) {
      selectOrg = await Get.bottomSheet(
        SelectOrganizationPage(
            organizations, (result) => Get.back(result: result)),
        ignoreSafeArea: true,
      );
    } else {
      selectOrg = organizations.first;
    }
    return selectOrg;
  }

  _startTime() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      state.sendTime.value = '已发送（${state.sendSMSCodeTime.value}）s';
      state.sendSMSCodeTime.value--;
      if (state.sendSMSCodeTime.value <= 0) {
        timer.cancel();
        state.sendTime.value = '发送验证码';
        state.isSend.value = false;
      }
    });
  }

  @override
  void onReady() {
    // TODO: implement onReady
  }

  @override
  void onClose() {
    if (timer != null && timer!.isActive) {
      timer!.cancel();
    }
  }
}
