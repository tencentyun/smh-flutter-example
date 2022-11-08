import 'package:get/get.dart';
import 'package:smh_flutter_sdk_example/routers/smh_routes.dart';

import '../pages/file_page/file_swipe_list.dart';
import '../pages/file_page/list_page/file_list/file_list_page.dart';
import '../pages/file_page/smh_preview_page.dart';
import '../pages/home/home.dart';
import '../pages/login/login_binding.dart';
import '../pages/login/login_page.dart';
import '../pages/mine_page/mine_binding.dart';
import '../pages/mine_page/mine_page.dart';
import '../pages/root/root_binding.dart';
import '../pages/root/root_page.dart';
import '../pages/transfer/transfer_swipe.dart';

class SMHPages {
  static final pages = [
    GetPage(
        name: SMHRoutes.LOGIN,
        page: () => LoginPage(),
        binding: LoginBinding()),
    GetPage(
        name: SMHRoutes.ROOT, page: () => RootPage(), binding: RootBinding()),
    GetPage(
      name: SMHRoutes.MINE,
      page: () => MinePage(),
      binding: MineBinding(),
    ),
    GetPage(name: SMHRoutes.HOME, page: () => HomePage()),
    GetPage(name: SMHRoutes.TRANSFER, page: () => TransferSwipePage()),
    GetPage(
      name: SMHRoutes.FILE,
      page: () => FileSwipeListPage(),
    ),
    GetPage(name: SMHRoutes.FILE_LIST, page: () => FileListPage()),
    GetPage(name: SMHRoutes.FILE_PREVIEW, page: () => SMHPreviewPage())
  ];
}
