import 'package:smh_flutter_sdk/model/user_model/smh_base_entity.dart';
import 'package:smh_flutter_sdk_example/transfer/smh_transfer.dart';
import 'package:smh_flutter_sdk_example/transfer/smh_transfer_speed.dart';

class SMHDownloadTransfer extends SMHTransfer with SMHTransferSpeed {
  SMHResponse<Map<String, dynamic>>? response;
}
