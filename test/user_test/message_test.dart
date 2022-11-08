import 'package:smh_flutter_sdk/apis/user_apis/smh_user_message_apis.dart';
import 'package:smh_flutter_sdk/model/user_model/smh_base_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_config.dart';

void main() {
  setUp(() {
    testSetup();
  });

  group('消息接口单测', () {
    test('修改用户消息配置', () async {
      SMHResponse? response;
      try {
        response = await SMHUesrMessageApis.updateMessageSetting(
          organizationId: orgId,
          userToken: userToken,
          authorityAndSettingMsg: true,
          shareMsg: true,
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 204, true);
    });
    test('查询用户接收消息配置', () async {
      SMHResponse? response;
      try {
        response = await SMHUesrMessageApis.getMessageSetting(
          organizationId: orgId,
          userToken: userToken,
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });

    test('用于删除所有消息', () async {
      SMHResponse? response;
      try {
        response = await SMHUesrMessageApis.deleteAllMessage(
          organizationId: orgId,
          userToken: userToken,
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 204, true);
    });

    test('用于删除部分消息', () async {
      SMHResponse? response;
      try {
        response = await SMHUesrMessageApis.batchDeleteMessage(
          organizationId: orgId,
          userToken: userToken,
          messageIds: ['1', '2'],
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 204, true);
    });

    test('用于标记所有消息已读', () async {
      SMHResponse? response;
      try {
        response = await SMHUesrMessageApis.readAllMessage(
          organizationId: orgId,
          userToken: userToken,
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 204, true);
    });

    test('用于标记消息已读', () async {
      SMHResponse? response;
      try {
        response = await SMHUesrMessageApis.readMessage(
          organizationId: orgId,
          userToken: userToken,
          messageIds: ['1', '3'],
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 204, true);
    });

    test('获取用户消息列表', () async {
      SMHResponse? response;
      try {
        response = await SMHUesrMessageApis.getMessageList(
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
