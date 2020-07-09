import 'package:flutter/material.dart';

class FlutterBuildInShapePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(title: Text('Flutter内置shape')),
        preferredSize: Size.fromHeight(44),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    final items = [
      _buildNoShape(),
      _buildBorderDirectional(),
      _buildBorder(),
      _buildCircleBorder(),
      _buildRoundedRectangleBorder(),
      _buildContinuousRectangleBorder(),
      _buildOutlineInputBorder(),
      _buildUnderlineInputBorder(),
    ];
    return ListView.separated(
      itemBuilder: (context, index) {
        return items[index];
      },
      separatorBuilder: (context, index) => Divider(
        color: Colors.transparent,
      ),
      itemCount: items.length,
      padding: EdgeInsets.all(18),
    );
  }

  TextStyle _textStyle() {
    return TextStyle(color: Colors.white, fontSize: 20);
  }

  Widget _buildNoShape() {
    return Material(
      color: Colors.orangeAccent,
      elevation: 10,
      child: Container(
        height: 80,
        alignment: Alignment.center,
        child: Text(
          'No Shape',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget _buildBorderDirectional() {
    return Material(
      color: Colors.orangeAccent,
      shape: BorderDirectional(
        top: BorderSide(color: Colors.blueAccent),
        bottom: BorderSide(color: Colors.blueAccent),
        start: BorderSide(color: Colors.black, width: 15),
        end: BorderSide(color: Colors.black87, width: 5),
      ),
      elevation: 2,
      child: Container(
        alignment: Alignment.center,
        height: 80,
        child: Text(
          'BorderDirectional',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }

  /// **Border** 通过*top*、*bottom*、*left*、*right*分别控制上下左右的边线，
  /// 本质上和BorderDirectional并没有什么区别
  Widget _buildBorder() {
    return Material(
      color: Colors.orangeAccent,
      textStyle: _textStyle(),
      shape: Border(
        top: BorderSide(color: Color(0xFFFFDFDFDF), width: 5),
        bottom: BorderSide(color: Color(0xFFFF7F7F7F), width: 5),
        left: BorderSide(color: Color(0xFFFFDFDFDF), width: 5),
        right: BorderSide(color: Color(0xFFFF7F7F7F), width: 5),
      ),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        height: 80,
        child: Text('Border'),
      ),
    );
  }

  /// ***CircleBorder*** 会以min(width, height)为直径，裁出一个圆形
  Widget _buildCircleBorder() {
    return Material(
      color: Colors.orangeAccent,
      textStyle: _textStyle().copyWith(fontSize: 12),
      shape: CircleBorder(
        side: BorderSide(width: 2, color: Color(0xFFFFDFDFDF)),
      ),
      elevation: 2,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(8),
        height: 80,
        child: Text('CircleBorder'),
      ),
    );
  }

  /// 圆角矩形
  Widget _buildRoundedRectangleBorder() {
    return Material(
      color: Colors.orangeAccent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        side: BorderSide(
          color: Colors.blueAccent,
          width: 2,
          style: BorderStyle.solid,
        ),
      ),
      textStyle: _textStyle(),
      elevation: 3,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        height: 80,
        child: Text('RoundedRectangleBorder'),
      ),
    );
  }

  Widget _buildContinuousRectangleBorder() {
    return Material(
      color: Colors.orangeAccent,
      textStyle: _textStyle(),
      elevation: 3,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        side: BorderSide(color: Colors.blueAccent, width: 2),
      ),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        height: 80,
        child: Text('ContinuousRectangleBorder'),
      ),
    );
  }

  /// 常用于输入框的边线
  Widget _buildOutlineInputBorder() {
    return Material(
      color: Colors.orangeAccent,
      elevation: 3,
      textStyle: _textStyle(),
      shape: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blueAccent, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        height: 80,
        child: Text('OutlineInputBorder'),
      ),
    );
  }

  Widget _buildUnderlineInputBorder() {
    return Material(
      color: Colors.orangeAccent,
      elevation: 3,
      textStyle: _textStyle(),
      shape: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.blueAccent, width: 20),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        height: 80,
        child: Text('UnderlineInputBorder'),
      ),
    );
  }
}
