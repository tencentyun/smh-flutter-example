import 'package:smh_flutter_sdk/apis/user_apis/smh_user_wechat_apis.dart';
import 'package:smh_flutter_sdk/model/enum/smh_string_enum.dart';
import 'package:smh_flutter_sdk/model/user_model/smh_base_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_config.dart';

void main() {
  setUp(() {
    testSetup();
  });

  group('微信接口', () {
    test('创建团队。', () async {
      SMHResponse? response;
      try {
        response = await SMHUserWechatApis.checkWechatAuth(
          organizationId: orgId,
          userToken: userToken,
          authType: SMHAuthType.mobile,
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });

    test('取消微信授权', () async {
      SMHResponse? response;
      try {
        response = await SMHUserWechatApis.unBindWechat(
          organizationId: orgId,
          userToken: userToken,
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 204, true);
    });
  });
}
