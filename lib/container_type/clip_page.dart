import 'package:flutter/material.dart';
import 'package:flutter_study/container_type/custom_path_clipper.dart';
import 'package:flutter_study/container_type/custom_rect_clipper.dart';

class ClipPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('裁剪')),
      body: _buildBody(context),
    );
  }

  /// ClipOval: 子组件为正方形时裁剪为内贴圆形，为矩形时，裁剪为内贴椭圆
  /// ClipRRect: 将子组件裁剪为圆角矩形
  /// ClipRect: 裁剪子组件到实际占用的矩形大小（溢出部分裁剪）

  Widget _buildBody(BuildContext context) {
    Widget image = Image.network(
      // 'https://cdn.jsdelivr.net/gh/dev-zhang/imgHosting/img/image-20200609160605063.png',
      'https://cdn.jsdelivr.net/gh/dev-zhang/imgHosting/img/235842557.jpg',
    );
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
            top: 20, bottom: MediaQuery.of(context).padding.bottom),
        child: Column(
          children: <Widget>[
            image,
            Container(
              margin: EdgeInsets.all(10),
              color: Colors.orangeAccent,
              child: ClipOval(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.network(
                    'https://cdn.jsdelivr.net/gh/dev-zhang/imgHosting/img/image-20200609160605063.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              // color: Colors.orangeAccent,
              margin: EdgeInsets.all(10),
              child: ClipOval(
                child: image,
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: ClipRRect(
                child: image,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    widthFactor: 0.5, // 宽度设置为原来的一半，另一半会溢出
                    child: image,
                  ),
                  Text(
                    'Flutter Yes!',
                    style: TextStyle(color: Colors.orange, fontSize: 38),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ClipRect(
                    // 裁剪溢出部分
                    child: Align(
                      alignment: Alignment.centerLeft,
                      widthFactor: 0.5,
                      child: image,
                    ),
                  ),
                  Text(
                    'Flutter Yes!',
                    style: TextStyle(color: Colors.orange, fontSize: 38),
                  ),
                ],
              ),
            ),
            // 裁剪特定区域
            Container(
              margin: EdgeInsets.all(10),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.orangeAccent,
                ),
                child: ClipRect(
                  clipper: CustomRectClipper(),
                  child: image,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.orangeAccent),
                child: ClipPath(
                  clipper: CustomPathClipper(),
                  child: image,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
