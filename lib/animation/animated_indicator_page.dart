import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_study/animation/widget/animated_circular_progress_indicator.dart';
import 'package:flutter_study/constant/constant.dart';

class AnimatedIndicatorPage extends StatefulWidget {
  @override
  _AnimatedIndicatorPageState createState() => _AnimatedIndicatorPageState();
}

class _AnimatedIndicatorPageState extends State<AnimatedIndicatorPage> {
  double _progress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(title: Text('带动画的指示器')),
        preferredSize: Size.fromHeight(kAppBarHeight),
      ),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  setState(() {
                    _progress = Random().nextDouble();
                  });
                },
                child: Icon(
                  Icons.refresh,
                  size: 60,
                ),
              ),
              SizedBox(height: 20),
              ClipRect(
                child: Container(
                  width: 200,
                  height: 200,
                  color: Colors.grey,
                  child: AnimatedCircularProgressIndicator(
                    duration: Duration(milliseconds: 400),
                    value: _progress,
                    strokeWidth: 18,
                    backgroundColor: Colors.orange,
                    strokeCap: StrokeCap.round,
                    startAngle: 0,
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
