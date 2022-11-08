import 'package:smh_flutter_sdk/apis/file_apis/smh_api_file_apis.dart';
import 'package:smh_flutter_sdk/core/request/smh_api_requests.dart';
import 'package:smh_flutter_sdk/model/user_model/smh_base_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_config.dart';

void main() {
  setUp(() {
    testSetup();
  });
  group('文件操作', () {
    test('删除文件', () async {
      SMHResponse? response;
      try {
        response = await SMHAPIFileApis.deleteFile(
          libraryId: libraryId,
          spaceId: spaceId,
          filePath: 'test.png',
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });

    test('复制文件', () async {
      SMHResponse? response;
      try {
        response = await SMHAPIFileApis.copyFile(
          libraryId: libraryId,
          spaceId: spaceId,
          filePath: '00000/IMG_0001_copy.JPG',
          copyFrom: '00000/IMG_0001.JPG',
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });

    test('查看文件详情', () async {
      SMHResponse? response;
      try {
        response = await SMHAPIFileApis.getFileDetail(
          libraryId: libraryId,
          spaceId: spaceId,
          filePath: '00000/IMG_0001_copy.JPG',
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });

    test('用于获取 HTML 格式文档预览', () async {
      SMHResponse? response;
      try {
        response = await SMHAPIFileApis.previewFileByHtml(
          libraryId: libraryId,
          spaceId: spaceId,
          filePath: '00000/test.pdf',
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 302, true);
    });

    test('获取文件下载链接和信息', () async {
      SMHResponse? response;
      try {
        response = await SMHAPIFileApis.getDownloadUrl(
          libraryId: libraryId,
          spaceId: spaceId,
          filePath: '00000/test.pdf',
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });

    test('获取照片/视频封面缩略图', () async {
      SMHResponse? response;
      try {
        response = await SMHAPIFileApis.getPreview(
          libraryId: libraryId,
          spaceId: spaceId,
          filePath: '00000/test.pdf',
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 302, true);
    });

    test('用于重命名或移动文件', () async {
      SMHResponse? response;
      try {
        response = await SMHAPIFileApis.moveOrRenameFile(
          libraryId: libraryId,
          spaceId: spaceId,
          filePath: '00000/test_rename.pdf',
          from: '00000/test.pdf',
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });

    test('检测文件状态', () async {
      SMHResponse? response;
      try {
        response = await SMHAPIFileApis.headFile(
          libraryId: libraryId,
          spaceId: spaceId,
          filePath: '00000/test_rename.pdf',
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });
  });
}
