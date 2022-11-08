import 'package:smh_flutter_sdk/apis/file_apis/smh_api_authority_apis.dart';
import 'package:smh_flutter_sdk/apis/file_apis/smh_api_batch_apis.dart';
import 'package:smh_flutter_sdk/apis/file_apis/smh_api_querytask_apis.dart';
import 'package:smh_flutter_sdk/apis/user_apis/smh_user_recycle_apis.dart';
import 'package:smh_flutter_sdk/apis/user_apis/smh_user_task_apis.dart';
import 'package:smh_flutter_sdk/model/api_model/s_m_h_api_task_result_entity.dart';
import 'package:smh_flutter_sdk/model/api_model/s_m_h_batch_copy_result_entity.dart';
import 'package:smh_flutter_sdk/model/api_model/s_m_h_batch_delete_result_entity.dart';
import 'package:smh_flutter_sdk/model/input/s_m_h_batch_copy_input_entity.dart';
import 'package:smh_flutter_sdk/model/input/s_m_h_batch_delete_input_entity.dart';
import 'package:smh_flutter_sdk/model/input/s_m_h_file_authority_item_entity.dart';
import 'package:smh_flutter_sdk/model/input/s_m_h_space_role_info_entity.dart';
import 'package:smh_flutter_sdk/model/input/s_m_h_user_role_info_entity.dart';
import 'package:smh_flutter_sdk/model/user_model/s_m_h_recycle_input_item_entity.dart';
import 'package:smh_flutter_sdk/model/user_model/s_m_h_task_result_entity.dart';
import 'package:smh_flutter_sdk/model/user_model/smh_base_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_config.dart';

void main() {
  setUp(() {
    testSetup();
  });
  group('批量操作接口', () {
    test('批量删除目录或文件', () async {
      SMHBatchDeleteInputEntity info = SMHBatchDeleteInputEntity();
      info.path = "/test";

      SMHResponse<SMHBatchDeleteResultEntity?>? response;
      try {
        response = await SMHAPIBatchApis.batchDeleteFile(
            libraryId: libraryId, spaceId: spaceId, inputs: [info]);
      } catch (e) {
        print(e);
      }
      expect(
          response?.statusCode == 200 ||
              response?.statusCode == 202 ||
              response?.statusCode == 207,
          true);

      if (response?.statusCode == 202) {
        // 当项目较多以异步方式删除时，返回 HTTP 202 Accepted
        // 以轮询的方式查询任务结果
        Future.delayed(Duration(seconds: 5), (() async {
          SMHResponse<List<SMHApiTaskResultEntity>>? taskResult =
              await SMHAPIQueryTaskApis.queryTask(
                  libraryId: libraryId,
                  spaceId: spaceId,
                  taskIdList: [response?.data?.taskId?.toString() ?? '']);
        }));
      }
    });

    test('批量复制目录或文件', () async {
      SMHResponse<SMHBatchCopyResultEntity?>? response;
      SMHBatchCopyInputEntity info = SMHBatchCopyInputEntity();
      info.copyFrom = "/copyFrom";
      info.copyFromLibraryId = 'copyFromLibraryId';
      info.copyFromSpaceId = 'copyFromSpaceId';
      info.to = "/to";
      try {
        response = await SMHAPIBatchApis.batchCopyFile(
            libraryId: libraryId, spaceId: spaceId, inputs: [info]);
      } catch (e) {
        print(e);
      }

      if (response?.statusCode == 202) {
        // 当项目较多以异步方式删除时，返回 HTTP 202 Accepted
        // 以轮询的方式查询任务结果
        Future.delayed(Duration(seconds: 5), (() async {
          SMHResponse<List<SMHApiTaskResultEntity>>? taskResult =
              await SMHAPIQueryTaskApis.queryTask(
                  libraryId: libraryId,
                  spaceId: spaceId,
                  taskIdList: [response?.data?.taskId?.toString() ?? '']);
        }));
      }
    });

    test('批量恢复', () async {
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
      if (response?.statusCode == 202) {
        // 当项目较多以异步方式删除时，返回 HTTP 202 Accepted
        // 以轮询的方式查询任务结果
        Future.delayed(Duration(seconds: 5), (() async {
          SMHResponse<SMHTaskResultEntity>? taskResult =
              await SMHUserTaskApis.getTaskState(
                  organizationId: orgId,
                  userToken: userToken,
                  taskIds: [response?.data?.taskId?.toString() ?? '']);
        }));
      }
    });
  });
}
