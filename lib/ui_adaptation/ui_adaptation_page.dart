import 'package:flutter/material.dart';

class UIAdaptationPage extends StatefulWidget {
  @override
  _UIAdaptationPageState createState() => _UIAdaptationPageState();
}

class _UIAdaptationPageState extends State<UIAdaptationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          title: Text('UI适配'),
        ),
        preferredSize: Size.fromHeight(44),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    final query = MediaQuery.of(context);
    final rpx = MediaQuery.of(context).size.width / 414;
    return SafeArea(
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.orangeAccent,
            // margin: EdgeInsets.fromLTRB(left, top, right, bottom),
            width: 414 * rpx,
            height: 80 * rpx,
          ),
          Container(
            color: Colors.blueAccent,
            width: 120,
            height: 60,
          )
        ],
      ),
    );
  }
}
