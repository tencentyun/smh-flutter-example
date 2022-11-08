import 'package:smh_flutter_sdk/apis/user_apis/smh_user_recycle_apis.dart';
import 'package:smh_flutter_sdk/model/user_model/s_m_h_list_recycle_space_item_entity.dart';
import 'package:smh_flutter_sdk/model/user_model/s_m_h_recycle_input_item_entity.dart';
import 'package:smh_flutter_sdk/model/user_model/smh_base_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_config.dart';

void main() {
  setUp(() {
    testSetup();
  });

  group('回收站接口', () {
    test('用于永久删除指定回收站项目（批量）', () async {
      SMHResponse? response;
      SMHRecycleInputItemEntity item = SMHRecycleInputItemEntity();
      item.spaceId = spaceId;
      item.recycledItemId = 1;
      try {
        response = await SMHUserRecycledApis.batchDeleteRecycleFile(
          organizationId: orgId,
          userToken: userToken,
          recycledItems: [item],
          withAllGroups: true,
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 204, true);
    });

    test('用于恢复指定回收站项目（批量）', () async {
      SMHResponse? response;
      SMHRecycleInputItemEntity item = SMHRecycleInputItemEntity();
      item.spaceId = spaceId;
      item.recycledItemId = 1;
      try {
        response = await SMHUserRecycledApis.batchRestoreRecycleFile(
          organizationId: orgId,
          userToken: userToken,
          recycledItems: [item],
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 204, true);
    });

    test('用于列出回收站项目，跨空间。', () async {
      SMHResponse? response;
      SMHListRecycleSpaceItemEntity item = SMHListRecycleSpaceItemEntity();
      item.spaceId = spaceId;
      item.includeChildSpace = true;
      try {
        response = await SMHUserRecycledApis.listRecycleItems(
          organizationId: orgId,
          userToken: userToken,
          spaceItems: [item],
        );
      } catch (e) {
        print(e);
      }
      expect(response?.statusCode == 200, true);
    });
  });
}
