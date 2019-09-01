import 'dart:convert';

import 'package:flutter/material.dart';
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

class Banner extends StatefulWidget {
  @override
  _BannerState createState() => _BannerState();
}

class _BannerState extends State<Banner> {
  @override
  Widget build(BuildContext context) {
    getBannerList();
    return Container(
      height: 200,
      color: Colors.red,
    );
  }

  getBannerList() async {
    await request(api["banner"]).then((val) {
      BannerModel list = BannerModel.fromJson(jsonDecode(val));
      print(list.data.slider[0].picUrl);
      // List slider = (val as Map)["data"]["slider"];
      // print(slider);
      // print("============");
      // Map data = (val as Map).cast();
      // print(jsonDecode(val) is Map);
      // print(data);
    });
  }
}
