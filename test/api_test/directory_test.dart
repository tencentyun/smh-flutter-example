import 'package:smh_flutter_sdk/apis/file_apis/smh_api_directory_apis.dart';
import 'package:smh_flutter_sdk/model/enum/smh_string_enum.dart';
import 'package:smh_flutter_sdk/model/user_model/smh_base_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_config.dart';

void main() {
  setUp(() {
    testSetup();
  });
  group('目录或相簿操作', () {
    test('列出目录或相簿内容', () async {
      SMHResponse? response;
      try {
        response = await SMHAPIDirectoryApis.listDirectory(
          libraryId: libraryId,
          spaceId: spaceId,
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });

    test('创建目录或相簿', () async {
      SMHResponse? response;
      try {
        response = await SMHAPIDirectoryApis.createDirectory(
          libraryId: libraryId,
          spaceId: spaceId,
          dirPath: 'test123123123',
          conflictResolutionStrategy: SMHConflictResolutionStrategy.rename,
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });
    test('用于删除目录或相簿', () async {
      SMHResponse? response;
      try {
        response = await SMHAPIDirectoryApis.deleteDirectory(
          libraryId: libraryId,
          spaceId: spaceId,
          dirPath: 'test123123123',
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 201, true);
    });

    test('用于复制目录或相簿', () async {
      SMHResponse? response;
      try {
        response = await SMHAPIDirectoryApis.copyDirectory(
          libraryId: libraryId,
          spaceId: spaceId,
          dirPath: 'test123123123123',
          copyFrom: '1',
          conflictResolutionStrategy: SMHConflictResolutionStrategy.rename,
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });

    test('查看目录或相簿详情', () async {
      SMHResponse? response;
      try {
        response = await SMHAPIDirectoryApis.getDirectoryDetail(
          libraryId: libraryId,
          spaceId: spaceId,
          dirPath: 'test',
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });
  });
}
