import 'package:smh_flutter_sdk/apis/user_apis/smh_user_directory_apis.dart';
import 'package:smh_flutter_sdk/model/enum/smh_string_enum.dart';
import 'package:smh_flutter_sdk/model/input/s_m_h_extra_info_input_entity.dart';
import 'package:smh_flutter_sdk/model/input/s_m_h_get_file_detail_input_entity.dart';
import 'package:smh_flutter_sdk/model/input/s_m_h_share_file_item_entity.dart';
import 'package:smh_flutter_sdk/model/user_model/smh_base_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_config.dart';

void main() {
  setUp(() {
    testSetup();
  });
  group('文件目录单测', () {
    test('批量获取文件/文件夹详情，可以跨空间。', () async {
      SMHResponse? response;
      try {
        SMHFileItemEntity item = SMHFileItemEntity();
        item.spaceId = spaceId;
        item.path = '1111test';
        item.type = SMHFileType.dir;

        SMHFileItemEntity item1 = SMHFileItemEntity();
        item.spaceId = spaceId;
        item.path = '1111test';
        item.type = SMHFileType.file;

        response = await SMHUserDirectoryApis.getFileDetailCrossSpace(
          organizationId: orgId,
          userToken: userToken,
          directoryInfoList: [item, item1],
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });

    test('指定空间下，批量获取文件或文件夹属性信息。', () async {
      SMHResponse? response;
      try {
        SMHGetFileDetailInputEntity item = SMHGetFileDetailInputEntity();
        item.path = '1111test';
        response = await SMHUserDirectoryApis.getFileDetailSingleSpace(
          organizationId: orgId,
          userToken: userToken,
          spaceId: spaceId,
          directoryInfoList: [item],
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });

    test('查看历史版本列表', () async {
      SMHResponse? response;
      try {
        response = await SMHUserDirectoryApis.getHistoryList(
          organizationId: orgId,
          userToken: userToken,
          dirPath: '1111test/图.png',
          spaceId: spaceId,
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });

    test('查看文件目录额外信息', () async {
      SMHResponse? response;
      try {
        SMHExtraInfoInputEntity item = SMHExtraInfoInputEntity();
        item.spaceId = spaceId;
        item.path = '1111test/图.png';
        response = await SMHUserDirectoryApis.getFileExtraInfo(
          organizationId: orgId,
          userToken: userToken,
          fileInfo: [item],
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });

    test('获取与我相关的文件列表', () async {
      SMHResponse? response;
      try {
        response = await SMHUserDirectoryApis.getRelatedToMeFileList(
          organizationId: orgId,
          userToken: userToken,
          limit: '20',
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });

    test('获取回收站目录详情', () async {
      SMHResponse? response;
      try {
        response = await SMHUserDirectoryApis.getRecycleItemDetail(
          organizationId: orgId,
          userToken: userToken,
          spaceId: spaceId,
          recycledItemId: 1,
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });

    test('获取文件目录详情', () async {
      SMHResponse? response;
      try {
        response = await SMHUserDirectoryApis.getFileListItemDetail(
          organizationId: orgId,
          userToken: userToken,
          spaceId: spaceId,
          path: '/',
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });

    test('获取最近使用文件列表', () async {
      SMHResponse? response;
      try {
        response = await SMHUserDirectoryApis.getRecentlyFileList(
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
