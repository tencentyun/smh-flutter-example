import 'package:flutter/material.dart';
import 'package:smh_flutter_sdk_example/pages/transfer/upload_list_component.dart';

import '../../config/colours.dart';
import '../../config/styles.dart';
import 'download_list_component.dart';

class TransferSwipePage extends StatefulWidget {
  const TransferSwipePage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _TransferSwipePageState();
  }
}

class _TransferSwipePageState extends State<TransferSwipePage>
    with TickerProviderStateMixin {
  List _tabs = [
    '下载文件',
    '上传文件',
  ];
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: _tabs.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "传输",
            style: TextStyles.bigTitle,
          ),
          centerTitle: false,
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(30),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TabBar(
                  isScrollable: true,
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs: _tabs
                      .map((e) => Padding(
                            padding: EdgeInsets.only(left: 0, right: 0),
                            child: Tab(
                              text: e,
                            ),
                          ))
                      .toList(),
                  labelColor: Colours.themeColor,
                  indicatorColor: Colours.themeColor,
                  unselectedLabelColor: Colours.textColor60,
                  controller: _tabController,
                ),
              ))),
      body: Center(
          child: TabBarView(
        controller: _tabController,
        children: [
          Container(
              alignment: Alignment.center, child: DownloadListComponent()),
          Container(alignment: Alignment.center, child: UploadListComponent())
        ],
      )),
    );
  }
}
