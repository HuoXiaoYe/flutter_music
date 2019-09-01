import 'package:flutter/material.dart';

import "./home.dart";
import "./commend.dart";
import "./activity.dart";
import "./person.dart";

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{
  List<Widget> widgetArr = [];
  int _activeIndex = 0;
  @override
  void initState() {
    widgetArr..add(Home())..add(Commend())..add(Activity())..add(Person());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _activeIndex,
        children: widgetArr,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int val) {
          setState(() {
            _activeIndex = val;
          });
        },
        currentIndex: _activeIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.library_music), title: Text("音乐馆")),
          BottomNavigationBarItem(icon: Icon(Icons.star), title: Text("推荐")),
          BottomNavigationBarItem(icon: Icon(Icons.star), title: Text("动态")),
          BottomNavigationBarItem(icon: Icon(Icons.person), title: Text("我的"))
        ],
      ),
    );
  }
}
