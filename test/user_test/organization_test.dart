import 'package:smh_flutter_sdk/apis/user_apis/smh_user_organization_apis.dart';
import 'package:smh_flutter_sdk/model/user_model/smh_base_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_config.dart';

void main() {
  setUp(() {
    testSetup();
  });

  group("组织操作接口", () {
    test('列出当前登录用户所属组织', () async {
      SMHResponse? response;
      try {
        response = await SMHUserOrganizationApis.listOrganizationsOfCurrentUser(
            userToken: userToken);
      } catch (e) {}
      expect(response?.statusCode = 200, true);
    });

    test('查询组织空间总使用量', () async {
      SMHResponse? response;
      try {
        response = await SMHUserOrganizationApis.getOrganizationSpaceUsage(
          organizationId: orgId,
          userToken: userToken,
        );
      } catch (e) {}
      expect(response?.statusCode = 200, true);
    });

    test('登录进指定组织', () async {
      SMHResponse? response;
      try {
        response = await SMHUserOrganizationApis.loginOrganization(
          organizationId: orgId,
          userToken: userToken,
        );
      } catch (e) {}
      expect(response?.statusCode = 204, true);
    });

    test('获取组织信息', () async {
      SMHResponse? response;
      try {
        response = await SMHUserOrganizationApis.getOrganizationInfo(
          organizationId: orgId,
          userToken: userToken,
        );
      } catch (e) {}
      expect(response?.statusCode = 200, true);
    });
  });

  test('获取组织分享列表', () async {
    SMHResponse? response;
    try {
      response = await SMHUserOrganizationApis.getOrganizationShareList(
        organizationId: orgId,
        userToken: userToken,
      );
    } catch (e) {}
    expect(response?.statusCode = 200, true);
  });
  test('获取组织历史版本参数', () async {
    SMHResponse? response;
    try {
      response = await SMHUserOrganizationApis.getOrganizationHistorySettings(
        organizationId: orgId,
        userToken: userToken,
      );
    } catch (e) {}
    expect(response?.statusCode = 200, true);
  });

  test('获取组织文件权限角色列表', () async {
    SMHResponse? response;
    try {
      response = await SMHUserOrganizationApis.getOrganizationRoleList(
        organizationId: orgId,
        userToken: userToken,
      );
    } catch (e) {}
    expect(response?.statusCode = 200, true);
  });
}
