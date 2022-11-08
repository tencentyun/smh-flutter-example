import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  List _tabs = [
    '收藏',
    '最近预览',
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
            "首页",
            style: TextStyle(fontSize: 16),
          ),
          centerTitle: false,
          actions: [
            IconButton(
              icon: Image(
                image: AssetImage('assets/images/nav/nav_scan.png'),
                width: 24,
                height: 24,
              ),
              tooltip: '扫一扫',
              onPressed: () {},
            ),
            IconButton(
              icon: Image(
                  image: AssetImage('assets/images/nav/nav_message.png'),
                  width: 24,
                  height: 24),
              tooltip: '消息',
              onPressed: () {},
            ),
            IconButton(
              icon: Image(
                  image: AssetImage('assets/images/nav/nav_more.png'),
                  width: 24,
                  height: 24),
              tooltip: '更多',
              onPressed: () {},
            )
          ],
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
                  labelColor: Color.fromRGBO(00, 0x52, 0xd9, 1),
                  indicatorColor: Color.fromRGBO(00, 0x52, 0xd9, 1),
                  unselectedLabelColor: Color.fromRGBO(0x30, 0x30, 0x30, 1),
                  controller: _tabController,
                ),
              ))),
      body: Center(
          child: TabBarView(
        controller: _tabController,
        children: _tabs.map((e) {
          return Container(
            alignment: Alignment.center,
            child: Text(e, textScaleFactor: 5),
          );
        }).toList(),
      )),
    );
  }

  Widget getFavoriteList() {
    return ListView();
  }
}
