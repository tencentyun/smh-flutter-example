import 'package:smh_flutter_sdk/apis/file_apis/smh_api_history_apis.dart';
import 'package:smh_flutter_sdk/apis/file_apis/smh_api_quota_apis.dart';
import 'package:smh_flutter_sdk/model/user_model/smh_base_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_config.dart';

void main() {
  setUp(() {
    testSetup();
  });
  group('文件历史操作', () {
    test('用于删除历史版本', () async {
      SMHResponse? response;
      try {
        response = await SMHAPIHistoryApis.deleteHistory(
          libraryId: libraryId,
          spaceId: spaceId,
          historyIds: ['123'],
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 204, true);
    });

    test('用于查询历史版本配置信息', () async {
      SMHResponse? response;
      try {
        response = await SMHAPIHistoryApis.getHistorySetting(
          libraryId: libraryId,
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });

    test('设置历史版本为最新版本', () async {
      SMHResponse? response;
      try {
        response = await SMHAPIHistoryApis.setLastVersion(
          libraryId: libraryId,
          spaceId: spaceId,
          historyId: '123',
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });

    test('设置历史版本配置信息', () async {
      SMHResponse? response;
      try {
        response = await SMHAPIHistoryApis.updateHistorySetting(
          libraryId: libraryId,
          enableFileHistory: false,
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 204, true);
    });

    test('获取租户空间配额', () async {
      SMHResponse? response;
      try {
        response = await SMHAPIQuotaApis.getSpaceCapacity(
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
