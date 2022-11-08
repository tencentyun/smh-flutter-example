import 'package:smh_flutter_sdk/apis/file_apis/smh_api_tag_apis.dart';
import 'package:smh_flutter_sdk/apis/file_apis/smh_api_usage_apis.dart';
import 'package:smh_flutter_sdk/model/enum/smh_string_enum.dart';
import 'package:smh_flutter_sdk/model/input/s_m_h_set_tag_input_entity.dart';
import 'package:smh_flutter_sdk/model/user_model/smh_base_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_config.dart';

void main() {
  setUp(() {
    testSetup();
  });
  group('标签操作接口', () {
    test('用于创建标签', () async {
      SMHResponse? response;
      try {
        response = await SMHAPITagApis.createTag(
          libraryId: libraryId,
          tagName: '师傅',
          tagType: SMHTagType.string,
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 204, true);
    });

    test('用于删除标签', () async {
      SMHResponse? response;
      try {
        response = await SMHAPITagApis.deleteTag(
          libraryId: libraryId,
          tagId: '148',
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 204, true);
    });

    test('删除给文件打的标签', () async {
      SMHResponse? response;
      SMHSetTagInputEntity entity = SMHSetTagInputEntity();
      entity.tagName = 'ceshi';
      entity.tagValue = '123';
      try {
        response = await SMHAPITagApis.deleteFileTag(
          libraryId: libraryId,
          spaceId: spaceId,
          fileTagId: '148',
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });

    test('用于给文件打标签', () async {
      SMHResponse? response;
      SMHSetTagInputEntity entity = SMHSetTagInputEntity();
      entity.tagId = 149;

      try {
        response = await SMHAPITagApis.setTagToFile(
          libraryId: libraryId,
          spaceId: spaceId,
          filePath: '00000/IMG_0004.JPG',
          tag: entity,
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });

    test('获取标签列表', () async {
      SMHResponse? response;
      try {
        response = await SMHAPITagApis.getTagList(
          libraryId: libraryId,
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });
  });

  group('空间使用量', () {
    test('查询 library 空间使用量', () async {
      SMHResponse? response;
      try {
        response = await SMHAPIUsageApis.getLibraryUsage(
          libraryId: libraryId,
          userId: userId,
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });

    test('列出租户空间', () async {
      SMHResponse? response;
      try {
        response = await SMHAPIUsageApis.getSpaceList(
          libraryId: libraryId,
          userId: userId,
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });
  });
}
