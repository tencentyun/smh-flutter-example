import 'package:smh_flutter_sdk/model/api_model/s_m_h_upload_fiile_result_entity.dart';
import 'package:smh_flutter_sdk/model/user_model/smh_base_entity.dart';
import 'package:smh_flutter_sdk_example/transfer/smh_transfer.dart';
import 'package:smh_flutter_sdk_example/transfer/smh_transfer_speed.dart';

class SMHUploadTransfer extends SMHTransfer with SMHTransferSpeed {
  SMHResponse<SMHUploadFileResultEntity>? response;
}
