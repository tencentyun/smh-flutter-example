import 'package:flutter/material.dart';

import '../../config/colours.dart';
import '../../config/styles.dart';
import 'file_component/file_list_component.dart';
import 'file_component/org_file_list_component.dart';

class FileSwipeListPage extends StatefulWidget {
  const FileSwipeListPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _FileSwipeListPageState();
  }
}

class _FileSwipeListPageState extends State<FileSwipeListPage>
    with TickerProviderStateMixin {
  List _tabs = [
    '企业空间',
    '个人空间',
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
            "文件",
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
          Container(alignment: Alignment.center, child: OrgFileListComponent()),
          Container(alignment: Alignment.center, child: FileListComponent())
        ],
      )),
    );
  }
}
