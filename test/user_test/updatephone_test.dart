import 'package:smh_flutter_sdk/apis/user_apis/smh_user_updatephone_apis.dart';
import 'package:smh_flutter_sdk/model/user_model/smh_base_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_config.dart';

void main() {
  setUp(() {
    testSetup();
  });

  group('更新手机号接口', () {
    test('发送短信验证码。', () async {
      SMHResponse? response;
      try {
        response = await SMHUserUpdatePhoneApis.sendSmsCode(
          organizationId: orgId,
          userToken: userToken,
          phoneMember: '15929443993',
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 204, true);
    });

    test('更新手机号', () async {
      SMHResponse? response;
      try {
        response = await SMHUserUpdatePhoneApis.updatePhone(
          organizationId: orgId,
          userToken: userToken,
          phoneMember: '15929443993',
          code: '11111',
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 204, true);
    });
  });
}
