import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../api/get_data.dart';
import '../config/url.dart';
import '../model/banner.dart';
import './search.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  List bannerList;
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: ListView(
        children: <Widget>[
          SearchContainer(), // 顶部搜索框
          Banner(), // 轮播图
          NavBar(), // 导航栏
        ],
      ),
    );
  }
}

// 顶部搜索框
class SearchContainer extends StatefulWidget {
  @override
  _SearchContainerState createState() => _SearchContainerState();
}

class _SearchContainerState extends State<SearchContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 40,
      child: Row(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            width: 80,
            child: Text(
              "音乐馆",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
              child: InkWell(
            onTap: () {
              // 跳转到 搜索页面
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => new Search()));
            },
            child: Container(
              alignment: Alignment.center,
              height: 30,
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.search, color: Colors.black87),
                  Padding(
                    padding: EdgeInsets.only(left: 4),
                    child: Text(
                      "搜索",
                      style: TextStyle(color: Colors.black87),
                    ),
                  )
                ],
              ),
            ),
          )),
          InkWell(
            onTap: () {
              // 跳转到 听歌识曲页面
            },
            child: Container(
              alignment: Alignment.center,
              width: 80,
              child: Icon(
                Icons.music_note,
                size: 30,
                color: Colors.black54,
              ),
            ),
          )
        ],
      ),
    );
  }
}

// 轮播图组件
class Banner extends StatefulWidget {
  // final List list;
  // Banner(this.list);
  @override
  _BannerState createState() => _BannerState();
}

class _BannerState extends State<Banner> {
  List bannerList = [];
  @override
  void initState() {
    getBannerList(); // 调用获取轮播图数据的方法
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.white,
      child: Swiper(
        itemCount: bannerList.length,
        itemBuilder: (BuildContext context, int index) {
          return new Container(
            padding: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 0.0),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Image.network(
                bannerList[index].picUrl,
                fit: BoxFit.fitHeight,
              ),
            ),
          );
        },
        pagination: new SwiperPagination(),
        autoplay: true,
      ),
    );
  }

  getBannerList() async {
    await request(api["banner"]).then((val) {
      BannerModel list = BannerModel.fromJson(jsonDecode(val));
      setState(() {
        bannerList = list.data.slider;
      });
    });
  }
}

final List navData = [
  {"icon": Icons.person, "title": "歌手"},
  {"icon": Icons.person, "title": "排行"},
  {"icon": Icons.person, "title": "分类歌单"},
  {"icon": Icons.person, "title": "电台"},
  {"icon": Icons.person, "title": "一起听"}
];

// 轮播图下方导航栏区域
class NavBar extends StatelessWidget {
  Widget _inkwellItem(item) {
    print("===============");
    print(item["title"]);
    return InkWell(
      onTap: () {},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.person, size: 44, color: Color.fromRGBO(34, 213, 157, 1)),
          Padding(
            padding: EdgeInsets.only(top: 0),
            child: Text(
              item["title"],
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: navData.map((item)=>_inkwellItem(item)).toList(),
      ),
    );
  }
}
