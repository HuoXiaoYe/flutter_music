import "package:flutter/material.dart";
import "./page/app.dart";

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color.fromRGBO(34, 213, 157, 1)
      ),
      home: MyApp(),
    );
  }
}