import 'package:smh_flutter_sdk/core/base/smh_service.dart';
import 'package:smh_flutter_sdk/core/base/smh_services_manager.dart';
import 'package:smh_flutter_sdk/core/services/smh_api_service.dart';
import 'package:smh_flutter_sdk/core/services/smh_user_service.dart';
import 'package:smh_flutter_sdk_example/smh_utils/refresh_accesstoken.dart';

const String phoneNumber = '';
const String userId = '';
const String countryCode = '';
const String userToken = '';

const String orgId = '';
const String libraryId = '';

const String spaceId = '';
const String accessToken = '';

void testSetup() {
  SMHServicesManager().registerService(SMHUserService());

  SMHAPIService apiService = SMHAPIService();
  apiService.setAccessTokenRefreshHandle(CustomRefreshAccessTokenHander());

  SMHServicesManager().registerService(apiService);

  SMHServicesManager().configHostWithEnv("", SMHHostType.dev);
  SMHServicesManager().setupCurrentEnv(SMHHostType.dev);
}
