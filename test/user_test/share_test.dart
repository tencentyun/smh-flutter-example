import 'package:smh_flutter_sdk/apis/user_apis/smh_user_share_apis.dart';
import 'package:smh_flutter_sdk/model/enum/smh_string_enum.dart';
import 'package:smh_flutter_sdk/model/input/s_m_h_share_file_item_entity.dart';
import 'package:smh_flutter_sdk/model/user_model/smh_base_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_config.dart';

void main() {
  setUp(() {
    testSetup();
  });

  group('分享接口', () {
    test('分享文件', () async {
      SMHResponse? response;
      SMHFileItemEntity item = SMHFileItemEntity();
      item.spaceId = spaceId;
      item.path = 'test';
      item.type = SMHFileType.dir;
      try {
        response = await SMHUserShareApis.shareFileInfo(
          organizationId: orgId,
          userToken: userToken,
          name: 'test',
          directoryInfoList: [item],
          expireTime: '2022-10-10',
          linkToLatestVersion: true,
          canPreview: true,
          canDownload: true,
          canSaveToNetDisc: true,
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });

    test('获取我分享的链接', () async {
      SMHResponse? response;
      try {
        response = await SMHUserShareApis.getMyShareFileList(
          organizationId: orgId,
          userToken: userToken,
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });

    test('获取分享链接信息（打开分享 url 时查询）', () async {
      SMHResponse? response;
      try {
        response = await SMHUserShareApis.getShareLinkDetailInfo(
            shareToken: 'dc43ad0a7b1d254ccf0e2f6fbc717d56');
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });

    test('获取链接详情', () async {
      SMHResponse? response;
      try {
        response = await SMHUserShareApis.getShareLinkDetail(
          organizationId: orgId,
          userToken: userToken,
          shareId: '3164',
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });

    test('删除分享链接', () async {
      SMHResponse? response;
      try {
        response = await SMHUserShareApis.deleteShareLink(
          organizationId: orgId,
          userToken: userToken,
          shareIds: ['325bdfdfe7b7e0e0be77666c43b51512'],
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });
  });
}
