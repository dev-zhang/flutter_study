import 'package:flutter/material.dart';
import 'package:flutter_study/canvas/bezier_path_page.dart';
import 'package:flutter_study/canvas/coordinate_system_page.dart';
import 'package:flutter_study/canvas/heart_shape_page.dart';
import 'package:flutter_study/canvas/widget/coordinate_system_widget.dart';
import 'package:flutter_study/constant/constant.dart';
import 'package:flutter_study/widget/example_tile.dart';

class CanvasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(title: Text('Canvas')),
        preferredSize: Size.fromHeight(kAppBarHeight),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          ExampleTile(
            title: '坐标系绘制',
            targetPage: CoordinateSystemPage(),
          ),
          ExampleTile(
            title: '爱心形状',
            targetPage: HeartShapePage(),
          ),
          ExampleTile(
            title: '贝塞尔曲线',
            targetPage: BezierPathPage(),
          ),
        ],
      ),
    );
  }
}
