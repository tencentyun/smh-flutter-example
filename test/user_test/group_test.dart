import 'package:smh_flutter_sdk/apis/user_apis/smh_user_group_apis.dart';
import 'package:smh_flutter_sdk/model/input/s_m_h_group_member_item_entity.dart';
import 'package:smh_flutter_sdk/model/user_model/smh_base_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_config.dart';

void main() {
  setUp(() {
    testSetup();
  });
  group('群组操作接口单测', () {
    test('修改群组成员权限或角色', () async {
      SMHResponse? response;
      try {
        SMHGroupMemberItemEntity item = SMHGroupMemberItemEntity();
        item.userId = '1';
        item.orgId = int.parse(orgId);

        response = await SMHUserGroupApis.updateGroupMemberAuthRole(
          organizationId: orgId,
          userToken: userToken,
          groupId: '1',
          users: [item],
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });

    test('列出用户所在群组', () async {
      SMHResponse? response;
      try {
        response = await SMHUserGroupApis.listGroupsOfMember(
          organizationId: orgId,
          userToken: userToken,
          checkUpdateRecursively: true,
          withDirectory: true,
          withFileCount: true,
          withUsers: true,
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });

    test('创建群组', () async {
      SMHResponse? response;
      try {
        response = await SMHUserGroupApis.createGroup(
          organizationId: orgId,
          userToken: userToken,
          name: '帅博的团队',
          users: [],
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });

    test('删除群组', () async {
      SMHResponse? response;
      try {
        response = await SMHUserGroupApis.deleteGroup(
          organizationId: orgId,
          userToken: userToken,
          groupId: '2009',
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 204, true);
    });

    test('删除群组成员', () async {
      SMHResponse? response;
      try {
        response = await SMHUserGroupApis.deleteGroupMember(
          organizationId: orgId,
          userToken: userToken,
          groupId: '2009',
          users: [],
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 204, true);
    });

    test('更新群组', () async {
      SMHResponse? response;
      try {
        response = await SMHUserGroupApis.updateGroup(
          organizationId: orgId,
          userToken: userToken,
          groupId: '29',
          name: '帅博的群组',
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 204, true);
    });

    test('查询用户创建的群组数量', () async {
      SMHResponse? response;
      try {
        response = await SMHUserGroupApis.getCountOfUserCreatedGroup(
          organizationId: orgId,
          userToken: userToken,
          userIds: [userId],
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });

    test('查询群组。', () async {
      SMHResponse? response;
      try {
        response = await SMHUserGroupApis.getGroupDetailInfo(
          organizationId: orgId,
          userToken: userToken,
          groupId: '2012',
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });

    test(' 添加群组成员', () async {
      SMHResponse? response;
      try {
        SMHGroupMemberItemEntity item = SMHGroupMemberItemEntity();
        item.userId = '59';
        item.orgId = int.parse(orgId);
        item.role = 'user';
        item.authRoleId = 1;
        response = await SMHUserGroupApis.addMemberToGroup(
          organizationId: orgId,
          userToken: userToken,
          groupId: '2012',
          users: [item],
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });

    test('退出群组（非群主）', () async {
      SMHResponse? response;
      try {
        response = await SMHUserGroupApis.exitGroup(
          organizationId: orgId,
          userToken: userToken,
          groupId: '2012',
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 204, true);
    });

    test('递归查询团队成员（仅移动端）', () async {
      SMHResponse? response;
      try {
        response = await SMHUserGroupApis.getTeamAllMembers(
          organizationId: orgId,
          userToken: userToken,
          groupId: '2012',
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 204, true);
    });
  });
}
