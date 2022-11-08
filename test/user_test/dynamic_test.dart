import 'package:smh_flutter_sdk/apis/user_apis/smh_user_dynamic_apis.dart';
import 'package:smh_flutter_sdk/model/enum/smh_string_enum.dart';
import 'package:smh_flutter_sdk/model/user_model/smh_base_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_config.dart';

void main() {
  setUp(() {
    testSetup();
  });
  group('动态单测', () {
    test('批量获取文件/文件夹详情，可以跨空间。', () async {
      SMHResponse? response;
      try {
        response = await SMHUserDynamicApis.getWorkspaceDynamic(
          organizationId: orgId,
          userToken: userToken,
          actionTypeDetail: [SMHDymanicActionType.rename],
          startTime: "2021-08-01T04:40:01.000Z",
          endTime: "2022-09-19T04:40:01.000Z",
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });

    test('查看单个空间', () async {
      SMHResponse? response;
      try {
        response = await SMHUserDynamicApis.getSpaceDynamic(
          organizationId: orgId,
          userToken: userToken,
          actionTypeDetail: [SMHDymanicActionType.rename],
          startTime: "2021-08-01T04:40:01.000Z",
          endTime: "2022-09-19T04:40:01.000Z",
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });

    test('继续获取空间或文件夹动态', () async {
      SMHResponse? response;
      try {
        response = await SMHUserDynamicApis.getNextSpaceDynamic(
            organizationId: orgId,
            userToken: userToken,
            searchId:
                'FlRUZUZySmhkVGZhMHBKVVVyQWZjdmchVFZaYmdvc2hTbUtYb180NnBzY3gyQToyNjEyNTA3NzU4');
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });
  });
}
