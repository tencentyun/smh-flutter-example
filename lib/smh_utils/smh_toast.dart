import 'package:fluttertoast/fluttertoast.dart';
import 'package:smh_flutter_sdk/core/error/smh_error.dart';

class SMHToast {
  static showMsg({required String msg}) {
    Fluttertoast.showToast(msg: msg, gravity: ToastGravity.CENTER);
  }

  static showError({required SMHError error}) {
    if (error.statusMessage == null &&
        error.smhMessage == null &&
        error.smhZhMessage == null) {
      Fluttertoast.showToast(
          msg: error.error.toString(), gravity: ToastGravity.CENTER);
    } else {
      Fluttertoast.showToast(
          msg: error.smhZhMessage ??
              error.smhMessage ??
              error.statusMessage ??
              '',
          gravity: ToastGravity.CENTER);
    }
  }
}
