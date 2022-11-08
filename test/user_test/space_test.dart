import 'package:smh_flutter_sdk/apis/user_apis/smh_user_space_apis.dart';
import 'package:smh_flutter_sdk/model/user_model/smh_base_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_config.dart';

void main() {
  setUp(() {
    testSetup();
  });

  group('空间操作接口', () {
    test('列出个人空间信息。', () async {
      SMHResponse? response;
      try {
        response = await SMHUserSpaceApis.getPersonSpace(
          organizationId: orgId,
          userToken: userToken,
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });

    test('列出团队空间', () async {
      SMHResponse? response;
      try {
        response = await SMHUserSpaceApis.getTeamSpace(
          organizationId: orgId,
          userToken: userToken,
          teamId: '123',
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });

    test('列出群组空间', () async {
      SMHResponse? response;
      try {
        response = await SMHUserSpaceApis.getGroupSpace(
          organizationId: orgId,
          userToken: userToken,
          groupId: '123',
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });

    test('获取个人空间信息和访问令牌', () async {
      SMHResponse? response;
      try {
        response = await SMHUserSpaceApis.getUserInfoAndAccessToken(
          organizationId: orgId,
          userToken: userToken,
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });

    test('获取指定空间访问令牌', () async {
      SMHResponse? response;
      try {
        response = await SMHUserSpaceApis.getSpaceAccessToken(
          organizationId: orgId,
          userToken: userToken,
          spaceId: spaceId,
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });
  });
}
