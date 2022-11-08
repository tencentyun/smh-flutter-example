import 'package:smh_flutter_sdk/apis/user_apis/smh_user_stats_apis.dart';
import 'package:smh_flutter_sdk/model/user_model/smh_base_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_config.dart';

void main() {
  setUp(() {
    testSetup();
  });

  group('统计接口', () {
    test('查询个人空间存储流量详情', () async {
      SMHResponse? response;
      try {
        response = await SMHUserStatsApis.getPresonSpaceStorageInfo(
          userToken: orgId,
          organizationId: userToken,
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });

    test('查询团队空间存储流量详情', () async {
      SMHResponse? response;
      try {
        response = await SMHUserStatsApis.getTeamSpaceStorageInfo(
          organizationId: orgId,
          userToken: userToken,
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });

    test('查询用户统计信息', () async {
      SMHResponse? response;
      try {
        response = await SMHUserStatsApis.getUserStatsInfo(
          organizationId: orgId,
          userToken: userToken,
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });

    test('查询空间存储信息统计信息', () async {
      SMHResponse? response;
      try {
        response = await SMHUserStatsApis.getSpacesStorageInfo(
          organizationId: orgId,
          userToken: userToken,
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });

    test('获取流量时序统计信息', () async {
      SMHResponse? response;
      try {
        response = await SMHUserStatsApis.getTrafficInfoWithTime(
            organizationId: orgId,
            userToken: userToken,
            startTime: "2022-07-10T01:01:00+08:00",
            endTime: "2022-09-17T20:59:00+08:00");
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });

    test('获取流量计费信息', () async {
      SMHResponse? response;
      try {
        response = await SMHUserStatsApis.getTrafficPrice(
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
