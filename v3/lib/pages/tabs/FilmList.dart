import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_1800/pages/user/loginView.dart';
import 'package:flutter_1800/service/firestore_service.dart';
import 'package:flutter_1800/tools/AppUtil.dart';
import 'package:flutter_1800/tools/config.dart';
import 'package:flutter_1800/tools/storage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FilmList extends StatefulWidget {
  int type = 0;
  FilmList(this.type, {Key? key}) : super(key: key);

  @override
  _FilmListState createState() => _FilmListState();
}

class _FilmListState extends State<FilmList>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  List list = [];

  @override
  void initState() {
    query();
  }

  // void changePost(post) {
  //   setState(() {
  //     selPost = post;
  //   });
  // }

  void query() async {
    List res = await FirestoreService.query();

    setState(() {
      list = res.where((element) {
        if (widget.type == 0) {
          DateTime releasetime = DateTime.parse(element["releasetime"]);
          return releasetime.millisecondsSinceEpoch <=
              DateTime.now().millisecondsSinceEpoch;
        } else if (widget.type == 1) {
          DateTime releasetime = DateTime.parse(element["releasetime"]);
          return releasetime.millisecondsSinceEpoch >
              DateTime.now().millisecondsSinceEpoch;
        } else {
          return true;
        }
      }).toList();
      if (widget.type == 2) {
        res.sort(((a, b) => -(a["score"] * 100 - b["score"] * 100).toInt()));
        list = res;
      }
    });
  }

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
    // // if failed,use refreshFailed()
  }

  void _onLoading() async {
    // monitor network fetch
    // await Future.delayed(Duration(milliseconds: 1000));
    // // if failed,use loadFailed(),if no data return,use LoadNodata()
    // items.add((items.length+1).toString());
    // if(mounted)
    // setState(() {

    // });
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppConfig.main,
        shadowColor: Colors.white,
        toolbarOpacity: 1,
        systemOverlayStyle:
            SystemUiOverlayStyle.light.copyWith(statusBarColor: AppConfig.main),
        actions: [
          TextButton(
              onPressed: () async {
                await StorageUtil.clear();
                AppUtil.getReplaceTo(const LoginViewPage());
              },
              child: const Text("exit"))
        ],
        title: Text(
          widget.type == 0
              ? "Release Now List"
              : (widget.type == 1 ? "Release Soon List" : "Top 20 List"),
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          header: const WaterDropHeader(),
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          cacheExtent: 1000,
          physics: const BouncingScrollPhysics(),
          child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                return getItem(index);
              })),
    );
  }

  Widget getItem(int index) {
    Map item = list[index];
    return GestureDetector(
        onTap: () {
          setState(() {});
        },
        behavior: HitTestBehavior.opaque,
        child: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(color: const Color(0xffeeeeee)),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.network(
                item["image"],
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Moive Name:" + item["name"],
                    style: const TextStyle(
                        color: AppConfig.font1,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Relase Time:" + item["releasetime"],
                    style: const TextStyle(color: AppConfig.font3),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Moive Type:" + item["moivetype"],
                    style: const TextStyle(color: AppConfig.font1),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Score:" + item["score"].toString(),
                    style: const TextStyle(
                        color: AppConfig.font1, fontWeight: FontWeight.bold),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
