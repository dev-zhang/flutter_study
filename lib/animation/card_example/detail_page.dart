import 'package:flutter/material.dart';
import 'package:flutter_study/constant/constant.dart';

class DetailPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(title: Text('详情页')),
        preferredSize: Size.fromHeight(kAppBarHeight),
      ),
      body: Column(
        children: <Widget>[
          Image.asset('assets/images/img_01.jpg'),
        ],
      ),
    );
  }
}
