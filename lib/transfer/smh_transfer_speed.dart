import 'dart:async';

import 'package:smh_flutter_sdk/utils/extension_utils.dart';
import 'package:get/get.dart';
import 'package:smh_flutter_sdk_example/transfer/smh_transfer.dart';

/// 计算传输速度
mixin SMHTransferSpeed on SMHTransfer {
  final speed = '0KB/s'.obs;

  Timer? _timer;
  var _lastProgress = 0;

  startListeningSpeed() {
    if (_timer != null && _timer!.isActive) {
      return;
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _computeSpeed();
    });
  }

  endListeningSpeed() {
    if (_timer == null || _timer!.isActive == false) {
      return;
    }
    _timer!.cancel();
    _timer = null;
  }

  _computeSpeed() {
    int temp = (progress.value - _lastProgress) < 0
        ? 0
        : (progress.value - _lastProgress);
    speed.value = temp.sizeFormart() + '/s';
    _lastProgress = progress.value;
  }
}
