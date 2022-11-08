import 'package:smh_flutter_sdk/apis/user_apis/smh_user_favorite_apis.dart';
import 'package:smh_flutter_sdk/model/user_model/smh_base_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_config.dart';

void main() {
  setUp(() {
    testSetup();
  });
  group('收藏操作单测', () {
    test('列出收藏夹', () async {
      SMHResponse? response;
      try {
        response = await SMHUserFavoriteApis.listFavoriteGroup(
          organizationId: orgId,
          userToken: userToken,
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });

    test('创建收藏夹', () async {
      SMHResponse? response;
      try {
        response = await SMHUserFavoriteApis.createFavoriteGroup(
          organizationId: orgId,
          userToken: userToken,
          name: '帅博',
          tag: 'test',
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });

    test('删除收藏', () async {
      SMHResponse? response;
      try {
        response = await SMHUserFavoriteApis.deleteFavorite(
          organizationId: orgId,
          userToken: userToken,
          favoriteIds: ['1'],
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 204, true);
    });

    test('删除收藏夹', () async {
      SMHResponse? response;
      try {
        response = await SMHUserFavoriteApis.deleteFavoriteGroup(
          organizationId: orgId,
          userToken: userToken,
          favoriteGroupId: '28',
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 204, true);
    });

    test('收藏文件目录', () async {
      SMHResponse? response;
      try {
        response = await SMHUserFavoriteApis.favoriteFilePath(
          organizationId: orgId,
          userToken: userToken,
          spaceId: spaceId,
          path: '1111test',
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });

    test('更新收藏夹', () async {
      SMHResponse? response;
      try {
        response = await SMHUserFavoriteApis.updateFavoriteGroup(
          organizationId: orgId,
          userToken: userToken,
          favoriteGroupId: '29',
          name: '帅博博',
          tag: 'test111',
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 204, true);
    });

    test('查看收藏列表', () async {
      SMHResponse? response;
      try {
        response = await SMHUserFavoriteApis.getFavoriteFileList(
          organizationId: orgId,
          userToken: userToken,
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });
  });
}
