import 'package:smh_flutter_sdk/apis/user_apis/smh_user_search_apis.dart';
import 'package:smh_flutter_sdk/model/user_model/smh_base_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_config.dart';

void main() {
  setUp(() {
    testSetup();
  });

  group('搜索接口', () {
    test('开始搜索团队', () async {
      SMHResponse? response;

      try {
        response = await SMHUesrSearchApis.searchTeam(
          organizationId: orgId,
          userToken: userToken,
          keyword: 'test',
          ancestorId: 1,
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });

    test('继续获取搜索结果', () async {
      SMHResponse? response;

      try {
        response = await SMHUesrSearchApis.searchNextTeam(
          organizationId: orgId,
          userToken: userToken,
          searchId:
              'FnhUb0p5SzJFU3gybVU4VTlQX0l3THchVFZaYmdvc2hTbUtYb180NnBzY3gyQToyNjE3NTQ0MDc0',
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });

    test('删除搜索任务', () async {
      SMHResponse? response;

      try {
        response = await SMHUesrSearchApis.deleteSearchTeam(
          organizationId: orgId,
          userToken: userToken,
          searchId:
              'FnhUb0p5SzJFU3gybVU4VTlQX0l3THchVFZaYmdvc2hTbUtYb180NnBzY3gyQToyNjE3NTQ0MDc0',
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 204, true);
    });
    // FnhUb0p5SzJFU3gybVU4VTlQX0l3THchVFZaYmdvc2hTbUtYb180NnBzY3gyQToyNjE3NTQ0MDc0
  });
}
