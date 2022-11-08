import 'package:smh_flutter_sdk/apis/file_apis/smh_api_recycle_apis.dart';
import 'package:smh_flutter_sdk/model/user_model/smh_base_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_config.dart';

void main() {
  setUp(() {
    testSetup();
  });
  group('回收站操作', () {
    test('用于列出回收站项目', () async {
      SMHResponse? response;
      try {
        response = await SMHAPIRecycledApis.listRecycleItems(
          libraryId: libraryId,
          spaceId: spaceId,
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });

    test('用于恢复指定回收站项目', () async {
      SMHResponse? response;
      try {
        response = await SMHAPIRecycledApis.restoreRecycleItem(
          libraryId: libraryId,
          spaceId: spaceId,
          recycledItemId: 9146944,
          accessToken: accessToken,
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });

    test('恢复指定回收站项目（批量）', () async {
      SMHResponse? response;
      try {
        response = await SMHAPIRecycledApis.batchRestoreRecycleItems(
          libraryId: libraryId,
          spaceId: spaceId,
          recycledItemIds: [9146945],
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });

    test('永久删除指定回收站项目（批量）', () async {
      SMHResponse? response;
      try {
        response = await SMHAPIRecycledApis.batchDeleteRecycleItems(
          libraryId: libraryId,
          spaceId: spaceId,
          recycledItemIds: [9146945],
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });

    test('清空回收站', () async {
      SMHResponse? response;
      try {
        response = await SMHAPIRecycledApis.clearRecycle(
          libraryId: libraryId,
          spaceId: spaceId,
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });
  });
}
