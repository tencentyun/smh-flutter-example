import 'package:smh_flutter_sdk/apis/user_apis/smh_user_invite_apis.dart';
import 'package:smh_flutter_sdk/model/enum/smh_string_enum.dart';
import 'package:smh_flutter_sdk/model/user_model/smh_base_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_config.dart';

void main() {
  setUp(() {
    testSetup();
  });

  group('邀请接口单测', () {
    test('删除邀请码', () async {
      SMHResponse? response;
      try {
        response = await SMHUserInviteApis.getOrganizationInviteInfo(
            code: 'xEe0GGilE4', organizationId: orgId, userToken: userToken);
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });

    test('删除邀请码', () async {
      SMHResponse? response;
      try {
        response = await SMHUserInviteApis.deleteInviteCode(
            organizationId: orgId, userToken: userToken, code: '3oJlKUCaJm');
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });

    test(' 接受加入群组邀请。', () async {
      SMHResponse? response;
      try {
        response = await SMHUserInviteApis.joinGroupByInvite(
          organizationId: orgId,
          userToken: userToken,
          code: '3oJlKUCaJm',
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });

    test(' 接受加入企业邀请。', () async {
      SMHResponse? response;
      try {
        response = await SMHUserInviteApis.joinOrganizationByInvite(
          organizationId: orgId,
          userToken: userToken,
          code: 'xEe0GGilE4',
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });

    test(' 查询当前企业邀请码', () async {
      SMHResponse? response;
      try {
        response = await SMHUserInviteApis.getOrganizationInviteCode(
          organizationId: orgId,
          userToken: userToken,
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });

    test(' 查询当前群组邀请码。', () async {
      SMHResponse? response;
      try {
        response = await SMHUserInviteApis.getGroupInviteCode(
          organizationId: orgId,
          userToken: userToken,
          groupId: '2012',
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });

    test('生成加入企业邀请码', () async {
      SMHResponse? response;
      try {
        response = await SMHUserInviteApis.createOrganizationInviteCode(
          organizationId: orgId,
          userToken: userToken,
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });

    test('生成加入群组邀请码。', () async {
      SMHResponse? response;
      try {
        response = await SMHUserInviteApis.createGroupInviteCode(
          organizationId: orgId,
          userToken: userToken,
          groupId: '2012',
          authRoleId: '1',
          allowExternalUser: true,
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });

    test('修改群组成员权限或角色', () async {
      SMHResponse? response;
      try {
        response = await SMHUserInviteApis.updateGroupInviteInfo(
          organizationId: orgId,
          userToken: userToken,
          code: 'yECLEfKfw4',
          enabled: false,
          role: SMHUserRole.user,
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });
  });
}
