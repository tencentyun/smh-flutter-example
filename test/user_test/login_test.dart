import 'package:smh_flutter_sdk/apis/user_apis/smh_user_login_apis.dart';
import 'package:smh_flutter_sdk/core/error/smh_error.dart';
import 'package:smh_flutter_sdk/model/user_model/smh_base_entity.dart';
import 'package:smh_flutter_sdk/model/user_model/smh_login_qrcode_entity.dart';
import 'package:smh_flutter_sdk/model/user_model/smh_organization_info.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_config.dart';

void main() {
  setUp(() {
    testSetup();
  });
  group('登录接口', () {
    test('发送验证码', () async {
      SMHResponse? response;
      try {
        response = await SMHUserLoginApis.sendSmsCode(
            phoneNumber: phoneNumber, countryCode: countryCode);
      } on SMHError catch (e) {
        print('catch');
      }
      expect(response?.data != null && response!.statusCode == 204, true);
    });

    test('根据短信验证码获取用户登录信息', () async {
      SMHResponse? response;
      try {
        response = await SMHUserLoginApis.smsCodeLogin(
            countryCode: countryCode, phoneNumber: phoneNumber, code: '000000');
      } on SMHError catch (e) {
        print('catch');
      }
      expect(response?.data != null && response!.statusCode == 200, true);
    });

    test('取消二维码，使登录二维码失效', () async {
      SMHResponse? response;
      try {
        response = await SMHUserLoginApis.cancelQrcodeLogin(
          organizationId: orgId,
          code: 'code',
          userToken: userToken,
        );
      } on SMHError catch (e) {
        print('catch');
      }
    });

    test('验证二维码', () async {
      SMHResponse? response;
      try {
        response = await SMHUserLoginApis.verifiedQrcodeLogin(
          organizationId: orgId,
          code: 'code',
          userToken: userToken,
        );
      } on SMHError catch (e) {
        print('catch');
      }
    });

    test('用于生成 APP 扫码登录的二维码。', () async {
      SMHResponse? response;
      try {
        response = await SMHUserLoginApis.getLoginQrcode(deviceId: 'iphone18');
      } on SMHError catch (e) {
        print('catch');
      }
      expect(response?.statusCode == 200, true);
    });

    test('根据玉符租户 ID，获取单点登录云盘地址。', () async {
      SMHResponse? response;
      try {
        response =
            await SMHUserLoginApis.getYufuLoginUrl(tenantName: 'tclouddisk');
      } on SMHError catch (e) {
        print('catch');
      }
      expect(response?.statusCode == 200, true);
    });

    test('用于生成 APP 扫码登录的二维码。', () async {
      SMHResponse<SMHLoginQrcodeEntity>? response;
      SMHResponse? response1;
      SMHResponse<SMHOrganizationInfoEntity>? response2;
      try {
        response = await SMHUserLoginApis.getLoginQrcode(deviceId: 'iphone18');

        response1 = await SMHUserLoginApis.confirmQrcodeLogin(
          organizationId: orgId,
          code: 'code',
          userToken: userToken,
        );
        response2 = await SMHUserLoginApis.loginByLoginQrcode(
            code: response!.data!.uuid!);
      } on SMHError catch (e) {
        print('catch');
      }
      // expect(response?.statusCode == 200, true);
      // expect(response1?.statusCode == 204, true);
      // expect(response2?.statusCode == 200, true);
    });
  });
}
