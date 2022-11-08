import 'package:flutter/material.dart';

import '../../config/colours.dart';
import '../file_page/file_swipe_list.dart';
import '../transfer/transfer_swipe.dart';
import '../mine_page/mine_page.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _index = 0;
  List<Widget> _rootPages = [
    FileSwipeListPage(),
    TransferSwipePage(),
    MinePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: _rootPages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _index,
        selectedFontSize: 13,
        unselectedFontSize: 13,
        onTap: _onBottomNavigationBarTap,
        items: [
          _getBottomNavigationBarItem(
              '文件',
              'assets/images/tabbar/tabbar_files.png',
              'assets/images/tabbar/tabbar_files_selected.png',
              0),
          _getBottomNavigationBarItem(
              '传输',
              'assets/images/tabbar/tabbar_transfer.png',
              'assets/images/tabbar/tabbar_transfer_selected.png',
              1),
          _getBottomNavigationBarItem(
              '个人',
              'assets/images/tabbar/tabbar_person.png',
              'assets/images/tabbar/tabbar_person_selected.png',
              2),
        ],
      ),
    );
  }

  _onBottomNavigationBarTap(int index) {
    setState(() {
      this._index = index;
    });
  }

  BottomNavigationBarItem _getBottomNavigationBarItem(
      String title, String icon, String selectIcon, int index) {
    return BottomNavigationBarItem(
        label: title,
        backgroundColor: Colours.backgroundColorF5,
        icon: _index == index
            ? Image.asset(selectIcon, height: 24, width: 24)
            : Image.asset(icon, height: 24, width: 24));
  }
}

// Future getImage() async {
//   final List<AssetEntity>? assets = await AssetPicker.pickAssets(context);
//   for (int i = 0; i < assets!.length; i++) {
//     AssetEntity entity = assets[i];
//
//     // Future.delayed(Duration(seconds: 5), () {
//     //   task.cancel(['手动取消']);
//     // });
//   }
//
// for (int i = 0; i < 50; i++) {
//   int i = 0;
//   final Directory tmpDir = await getTemporaryDirectory();
//   String path = tmpDir.path + '/' + 'test$i.mp4';
//   SMHDownloadTask task = await SMHApiTransferApis.download(
//     User.currentUser.libraryId!,
//     User.currentUser.spaceId!,
//     User.currentUser.userId!,
//     path,
//     'test.mp4',
//     userToken: User.currentUser.userToken,
//     orgId: User.currentUser.organizationId,
//     finishCalBack: (result, error) {
//       if (error != null) {
//         print('下载失败$i:${error.toJson().toString()}');
//       } else {
//         print('下载完成$i:${result.toString()}');
//       }
//     },
//     onReceiveProgress: (count, total) {
//       // if (count == total) {
//       print(
//           '下载中$i _count:' + count.toString() + ';total:' + total.toString());
//       // }
//       // print('下载中_count:' + count.toString() + ';total:' + total.toString());
//     },
//   );
// }
// }
