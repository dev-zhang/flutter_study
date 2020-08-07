import 'package:flutter/material.dart';
import 'package:flutter_study/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter study',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        cardColor: Color(0xff426ab3),
        primaryTextTheme: TextTheme(
          title: TextStyle(color: Colors.white),
        ),
        textTheme: TextTheme(
          button: TextStyle(
            color: Colors.white,
          ),
        ),
        accentTextTheme: TextTheme(
          title: TextStyle(color: Colors.white),
        ),
      ),
      home: HomePage(),
    );
  }
}
