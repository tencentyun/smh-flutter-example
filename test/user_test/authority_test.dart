import 'package:smh_flutter_sdk/apis/user_apis/smh_user_authority_apis.dart';
import 'package:smh_flutter_sdk/model/user_model/smh_base_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_config.dart';

void main() {
  setUp(() {
    testSetup();
  });

  group("文件目录授权操作单测", () {
    test('列出当前登录用户所属组织', () async {
      SMHResponse? response;
      try {
        response = await SMHUserAuthorityApis.getDirectoryAuthority(
          organizationId: orgId,
          userToken: userToken,
          dirPath: '/test',
          dirLibraryId: libraryId,
          dirSpaceId: spaceId,
        );
      } catch (e) {
        expect(e == null, true);
      }
      expect(response?.statusCode == 200, true);
    });

    test('获取与我相关的共享文件列表', () async {
      SMHResponse? response;
      try {
        response = await SMHUserAuthorityApis.getRelatedAuthorizationFileList(
          organizationId: orgId,
          userToken: userToken,
        );
      } catch (e) {
        expect(e == null, true);
      }
      expect(response?.statusCode == 200, true);
    });

    test('获取共享给我的文件夹', () async {
      SMHResponse? response;
      try {
        response = await SMHUserAuthorityApis.getReceivedAuthorizationFileList(
          organizationId: orgId,
          userToken: userToken,
        );
      } catch (e) {
        expect(e == null, true);
      }
      expect(response?.statusCode == 200, true);
    });
  });
}
