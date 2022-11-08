import 'package:smh_flutter_sdk/apis/user_apis/smh_user_account_apis.dart';
import 'package:smh_flutter_sdk/apis/user_apis/smh_user_space_apis.dart';
import 'package:smh_flutter_sdk/core/error/smh_error.dart';
import 'package:smh_flutter_sdk/model/enum/smh_string_enum.dart';
import 'package:smh_flutter_sdk/model/user_model/smh_base_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_config.dart';

void main() {
  setUp(() {
    testSetup();
  });
  group('用户操作接口单测', () {
    test('查询用户个人信息，移动端在下载个人信息时使用。', () async {
      SMHResponse? response;
      try {
        response = await SMHUserAccountApis.downloadPersonInfo(
          organizationId: orgId,
          code: 'code',
          userToken: userToken,
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });

    test('批量删除用户', () async {
      SMHResponse? response;
      try {
        response = await SMHUserAccountApis.batchDeleteUser(
          organizationId: orgId,
          userToken: userToken,
          userIds: ['-1'],
        );
      } on SMHError catch (e) {}
      expect(response?.statusCode == 200, true);
    });

    test('更新用户信息。', () async {
      SMHResponse? response;
      try {
        response = await SMHUserAccountApis.updatePersonInfo(
          organizationId: orgId,
          userToken: userToken,
          userId: userId,
          nickname: '帅哥',
        );
      } on SMHError catch (e) {}
      expect(response?.statusCode == 204, true);
    });

    test('查询用户', () async {
      SMHResponse? response;
      try {
        response = await SMHUserAccountApis.getPersonInfo(
          organizationId: orgId,
          userToken: userToken,
          userId: userId,
          withBelongingTeams: true,
          withSpaceUsage: true,
        );
      } on SMHError catch (e) {
        expect(e.smhCode == 'UserNotFound', true);
        return;
      }
      expect(response?.statusCode == 200, true);
    });

    test('查询用户列表。', () async {
      SMHResponse? response;
      try {
        response = await SMHUserAccountApis.getPersonListInfo(
          organizationId: orgId,
          userToken: userToken,
          withBelongingTeams: true,
          withSpaceUsage: true,
        );
      } on SMHError catch (e) {}
      print(response?.data.toString());
      expect(response?.statusCode == 200, true);
    });

    test('获取头像简单上传文件参数', () async {
      SMHResponse? response;
      try {
        response = await SMHUserAccountApis.getUploadAvatarParams(
            userToken: userToken, fileExt: SMHUploadAvatar.png);
      } on SMHError catch (e) {}
      print(response?.data.toString());
      expect(response?.statusCode == 200, true);
    });
  });

  group('accesstoken', () {
    test('getUserInfoAndAccessToken', () async {
      SMHResponse? response;
      try {
        response = await SMHUserSpaceApis.getUserInfoAndAccessToken(
          organizationId: orgId,
          userToken: userToken,
        );
      } on SMHError catch (e) {}
      expect(response?.statusCode == 200, true);
    });

    test('getSpaceAccessToken', () async {
      SMHResponse? response;
      try {
        response = await SMHUserSpaceApis.getSpaceAccessToken(
          organizationId: orgId,
          userToken: userToken,
          spaceId: spaceId,
        );
      } on SMHError catch (e) {}
      expect(response?.statusCode == 200, true);
    });
  });
}
