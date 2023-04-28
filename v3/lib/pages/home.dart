import 'package:flutter/material.dart';
import 'package:flutter_1800/pages/tabs/FilmList.dart';
import 'package:flutter_1800/pages/user/loginView.dart';
import 'package:flutter_1800/tools/AppUtil.dart';
import 'package:flutter_1800/tools/config.dart';
import 'package:flutter_1800/tools/storage.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  var user;

  late TabController _tabController;
  double imageWidth = 25;

  late List<Map> _tabs;
  late Map _selectedTab;

  @override
  void initState() {
    super.initState();

    _tabs = [
      {
        "name": "Released Now",
        "icon": const Icon(
          Icons.home,
          size: 20,
        ),
        "selectedIcon": const Icon(
          Icons.home,
          size: 20,
          color: AppConfig.main,
        ),
      },
      {
        "name": "Released Soon",
        "icon": const Icon(
          Icons.home,
          size: 20,
        ),
        "selectedIcon": const Icon(
          Icons.home,
          size: 20,
          color: AppConfig.main,
        ),
      },
      {
        "name": "Top 20",
        "icon": const Icon(
          Icons.people,
          size: 20,
        ),
        "selectedIcon": const Icon(
          Icons.people,
          size: 20,
          color: AppConfig.main,
        ),
      }
    ];
    _selectedTab = _tabs[0];

    _tabController = TabController(length: _tabs.length, vsync: this);
    login();
  }

  void login() async {
    var u = await StorageUtil.getUser();

    if (u == null) {
      AppUtil.getReplaceTo(const LoginViewPage());
    } else {
      AppUtil.user = u;
      setState(() {
        user = u;
      });
      // WebscoketClient.init();
    }
  }

  String timeFormat(String time) {
    DateTime nowTime = DateTime.parse(time);
    return DateFormat('yyyy-MM-dd hh:mm:ss').format(nowTime);
  }

  void unagreeHandler() {}

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: _tabs.length,
        initialIndex: 0,
        child: Scaffold(
          bottomNavigationBar: TabBar(
            controller: _tabController,
            tabs: _tabs
                .map((e) => Tab(
                    text: e["name"],
                    icon: e == _selectedTab ? e["selectedIcon"] : e["icon"]))
                .toList(),
            onTap: (index) {
              setState(() {
                _selectedTab = _tabs[index];
              });
            },
          ),
          body: TabBarView(
            controller: _tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              FilmList(0),
              FilmList(1),
              FilmList(2),
            ],
          ),
        ));
  }
}
