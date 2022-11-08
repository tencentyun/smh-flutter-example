import 'package:smh_flutter_sdk/core/accesstoken/smh_refresh_accesstoken_handler.dart';
import 'package:smh_flutter_sdk/model/user_model/s_m_h_access_token_entity.dart';
import 'package:smh_flutter_sdk/model/user_model/smh_base_entity.dart';
import 'package:smh_flutter_sdk/apis/user_apis/smh_user_space_apis.dart';

import '../models/user.dart';

class CustomRefreshAccessTokenHander extends SMHRefreshAccessTokenHander {
  @override
  Future<SMHAccessTokenEntity>? refreshAccessToken(
      String? spaceId, String? spaceOrgId) async {
    if (spaceId == null) {
      SMHResponse? response;
      try {
        response = await SMHUserSpaceApis.getUserInfoAndAccessToken(
            organizationId: User.currentUser.organizationId!,
            userToken: User.currentUser.userToken!);
      } catch (e) {}
      updateAccessToken(response?.data);
      return response?.data;
    } else {
      SMHResponse? response;
      try {
        response = await SMHUserSpaceApis.getSpaceAccessToken(
            organizationId: User.currentUser.organizationId!,
            userToken: User.currentUser.userToken!,
            spaceId: spaceId,
            spaceOrgId: spaceOrgId);
      } catch (e) {}
      updateAccessToken(response?.data);
      return response?.data;
    }
  }

  updateAccessToken(SMHAccessTokenEntity? entity) {
    if (entity != null) {
      User.currentUser.accessToken = entity.accessToken;
      User.currentUser.updateCache();
    }
  }
}
