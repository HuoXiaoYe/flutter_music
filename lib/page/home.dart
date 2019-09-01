import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../api/get_data.dart';
import '../config/url.dart';
import '../model/banner.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: ListView(
        children: <Widget>[
          Banner(), // 轮播图
        ],
      ),
    );
  }
}

// 顶部搜索框

// 轮播图组件
class Banner extends StatefulWidget {
  @override
  _BannerState createState() => _BannerState();
}

class _BannerState extends State<Banner> {
  List bannerList = [];
  @override
  Widget build(BuildContext context) {
    getBannerList(); // 调用获取轮播图数据的方法
    return Container(
      height: 200,
      color: Colors.white,
      child: Swiper(
        itemCount: bannerList.length,
        itemBuilder: (BuildContext context, int index) {
          return new Container(
            padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Image.network(
                bannerList[index].picUrl,
                fit: BoxFit.fitHeight,
              ),
            ),
            // color: Colors.red,
            // child: Container(
            //   height: 190.0,
            //   decoration: BoxDecoration(
            //       // borderRadius: BorderRadius.all(Radius.circular(10))
            //       ),
            //   child: ClipRRect(
            //     borderRadius: BorderRadius.all(Radius.circular(10)),
            //     child: Image.network(
            //       bannerList[index].picUrl,
            //       fit: BoxFit.fitHeight,
            //     ),
            //   ),
            // ),
          );
        },
        pagination: new SwiperPagination(),
      ),
    );
  }

  getBannerList() async {
    await request(api["banner"]).then((val) {
      BannerModel list = BannerModel.fromJson(jsonDecode(val));
      // print(list.data.slider);
      setState(() {
        bannerList = list.data.slider;
      });
      // List slider = (val as Map)["data"]["slider"];
      // print(slider);
      // print("============");
      // Map data = (val as Map).cast();
      // print(jsonDecode(val) is Map);
      // print(data);
    });
  }
}
