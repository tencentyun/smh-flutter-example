import 'package:smh_flutter_sdk/apis/user_apis/smh_user_team_apis.dart';
import 'package:smh_flutter_sdk/model/input/s_m_h_member_authority_entity.dart';
import 'package:smh_flutter_sdk/model/user_model/smh_base_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_config.dart';

void main() {
  setUp(() {
    testSetup();
  });

  group('团队接口', () {
    test('创建团队。', () async {
      SMHResponse? response;
      try {
        response = await SMHUserTeamApis.createTeam(
          organizationId: orgId,
          userToken: userToken,
          name: '帅博的team',
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });

    test('修改团队成员权限', () async {
      SMHResponse? response;
      try {
        SMHMemberAuthorityEntity entity = SMHMemberAuthorityEntity();
        entity.userId = '1';
        entity.name = '师傅';
        entity.roleId = 1;
        response = await SMHUserTeamApis.updateMemberAuthority(
          organizationId: orgId,
          userToken: userToken,
          teamId: '2191',
          authorizeTo: [entity],
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 204, true);
    });

    test('删除团队', () async {
      SMHResponse? response;
      try {
        response = await SMHUserTeamApis.deleteTeam(
          organizationId: orgId,
          userToken: userToken,
          teamId: '2191',
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 202 || response?.statusCode == 204, true);
    });

    test('删除团队成员', () async {
      SMHResponse? response;
      try {
        response = await SMHUserTeamApis.deleteTeamMember(
          organizationId: orgId,
          userToken: userToken,
          teamId: '2192',
          userIds: ['1'],
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 204, true);
    });

    test('删除团队管理员', () async {
      SMHResponse? response;
      try {
        response = await SMHUserTeamApis.deleteTeamAdmin(
          organizationId: orgId,
          userToken: userToken,
          teamId: '2192',
          userIds: ['1'],
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 204, true);
    });

    test('更新团队', () async {
      SMHResponse? response;
      try {
        response = await SMHUserTeamApis.updateTeam(
          organizationId: orgId,
          userToken: userToken,
          teamId: '2192',
          name: '师傅的团队',
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 204, true);
    });

    test('查询团队', () async {
      SMHResponse? response;
      try {
        response = await SMHUserTeamApis.getTeamDetailInfo(
          organizationId: orgId,
          userToken: userToken,
          checkPermission: true,
          teamId: '2192',
          withPath: true,
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 204, true);
    });

    test('查询该团队及其所有子级团队的成员', () async {
      SMHResponse? response;
      try {
        response = await SMHUserTeamApis.getAllTeamMemberInfo(
          organizationId: orgId,
          userToken: userToken,
          teamId: '2100',
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 204, true);
    });
  });
}
