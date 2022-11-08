import 'package:smh_flutter_sdk/apis/user_apis/smh_user_deregister_apis.dart';
import 'package:smh_flutter_sdk/core/error/smh_error.dart';
import 'package:smh_flutter_sdk/core/error/smh_error_code.dart';
import 'package:smh_flutter_sdk/model/user_model/smh_base_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_config.dart';

void main() {
  setUp(() {
    testSetup();
  });

  group("注销操作单测", () {
    test('在企业成员注销犹豫期，驳回其它成员提交的注销操作', () async {
      SMHResponse? response;
      try {
        response = await SMHUserDeregisterApis.cancelMemberDeregister(
          organizationId: orgId,
          userId: userId,
          userToken: userToken,
        );
      } on SMHError catch (e) {
        expect(e.smhCode == SMHErrorCode.UserIsNotUnderDeregister, true);
        return;
      }
      expect(response?.statusCode == 200, true);
    });

    test('检查企业成员是否满足注销条件', () async {
      SMHResponse? response;
      try {
        response = await SMHUserDeregisterApis.checkMemberCanDeregister(
          organizationId: orgId,
          userToken: userToken,
        );
      } on SMHError catch (e) {}
      expect(response?.statusCode == 200, true);
    });

    test('在指定组织中注销账户', () async {
      SMHResponse? response;
      try {
        response = await SMHUserDeregisterApis.memberDeregister(
          organizationId: orgId,
          userToken: userToken,
        );
      } on SMHError catch (e) {
        expect(
            e.smhCode == SMHErrorCode.DeregisterNotAllowedForSuperAdmin, true);
        return;
      }
      expect(response?.statusCode == 200, true);
    });
  });
}
