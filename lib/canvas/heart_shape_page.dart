import 'package:flutter/material.dart';
import 'package:flutter_study/canvas/widget/cardioid_widget.dart';
import 'package:flutter_study/canvas/widget/cubic_heart_widget.dart';
import 'package:flutter_study/canvas/widget/heart_shape.dart';
import 'package:flutter_study/constant/constant.dart';

class HeartShapePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(title: Text('爱心')),
        preferredSize: Size.fromHeight(kAppBarHeight),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                width: double.infinity,
                child: CubicHeartWidget(),
              ),
              SizedBox(
                width: double.infinity,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: CardioidWidget(),
                ),
              ),
              SizedBox(
                width: 260,
                height: 200,
                child: Container(
                  // color: Colors.grey,
                  child: HeartShape(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
