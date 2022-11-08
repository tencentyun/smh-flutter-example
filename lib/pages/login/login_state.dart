import 'package:get/get.dart';

class LoginState {
  final phone = ''.obs;
  final countryCode = '+86'.obs;
  final smsCode = ''.obs;
  final sendSMSCodeTime = 60.obs;
  final isSend = false.obs;

  final sendTime = ''.obs;
}
