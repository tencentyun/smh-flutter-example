import 'package:smh_flutter_sdk/apis/file_apis/smh_api_authority_apis.dart';
import 'package:smh_flutter_sdk/model/enum/smh_string_enum.dart';
import 'package:smh_flutter_sdk/model/input/s_m_h_file_authority_item_entity.dart';
import 'package:smh_flutter_sdk/model/input/s_m_h_space_role_info_entity.dart';
import 'package:smh_flutter_sdk/model/input/s_m_h_user_role_info_entity.dart';
import 'package:smh_flutter_sdk/model/user_model/smh_base_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_config.dart';

void main() {
  setUp(() {
    testSetup();
  });
  group('文件权限接口', () {
    test('test', () {
      SMHFileType.multi_file.name;
      var test2 = SMHActionType.Login.name;
      var test1 = SMHFileType.byName('multi-file');
      var test = SMHFileType.multi_file.name;
      print(test);
    });

    test('主动退出文件/文件夹权限', () async {
      SMHResponse? response;
      SMHUserRoleInfoEntity info = SMHUserRoleInfoEntity();
      info.userId = '1';
      info.name = '张三';
      info.roleId = 1;
      try {
        response = await SMHAPIAuthorityApis.exitFileAuthority(
          libraryId: libraryId,
          spaceId: spaceId,
          path: 'test',
          authorizeTo: [info],
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 204, true);
    });

    test('给文件夹分配权限', () async {
      SMHResponse? response;
      SMHFileAuthorityItemEntity info = SMHFileAuthorityItemEntity();
      info.userId = '1';
      info.name = '张三';
      info.roleId = 1;
      try {
        response = await SMHAPIAuthorityApis.authorityFile(
          libraryId: libraryId,
          spaceId: spaceId,
          path: 'test',
          authorizeTo: [info],
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 204, true);
    });

    test('给空间分配权限', () async {
      SMHResponse? response;
      SMHSpaceRoleInfoEntity info = SMHSpaceRoleInfoEntity();
      info.spaceId = spaceId;
      info.name = 'test';
      info.roleId = 1;
      try {
        response = await SMHAPIAuthorityApis.authorityFileToSpace(
          libraryId: libraryId,
          spaceId: spaceId,
          authorizeTo: info,
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 204, true);
    });

    test('删除文件夹权限', () async {
      SMHFileAuthorityItemEntity item = SMHFileAuthorityItemEntity();
      item.userId = '1';
      item.name = 'test';
      item.roleId = 1;

      SMHResponse? response;
      try {
        response = await SMHAPIAuthorityApis.deleteFileAuthority(
          libraryId: libraryId,
          spaceId: spaceId,
          path: 'test',
          authorizeTo: [item],
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 204, true);
    });

    test('获取我共享的文件夹', () async {
      SMHResponse? response;
      try {
        response = await SMHAPIAuthorityApis.getAuthorizedDirectory(
          libraryId: libraryId,
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 204, true);
    });

    test('用于获取角色列表', () async {
      SMHResponse? response;
      try {
        response = await SMHAPIAuthorityApis.getRoleList(
          libraryId: libraryId,
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });
  });
}
