import 'package:smh_flutter_sdk/apis/user_apis/smh_user_space_apis.dart';
import 'package:get/get.dart';
import 'package:smh_flutter_sdk/core/error/smh_error.dart';
import 'package:smh_flutter_sdk/model/user_model/smh_base_entity.dart';
import 'package:smh_flutter_sdk_example/smh_utils/smh_toast.dart';

import '../../models/user.dart';
import '../../routers/smh_routes.dart';
import 'mine_state.dart';

class MineController extends GetxController {
  final MineState state = MineState();

  logout() {
    User.currentUser.remove();
    Get.offAllNamed(SMHRoutes.LOGIN);
  }

  @override
  void onReady() async {
    try {
      SMHResponse? response = await SMHUserSpaceApis.getPersonSpace(
          organizationId: User.currentUser.organizationId!,
          userToken: User.currentUser.userToken!);
      if (response == null) {
        return;
      }
      state.spaceEntity.value = response.data;
    } on SMHError catch (e) {
      SMHToast.showError(error: e);
    }
  }
}
