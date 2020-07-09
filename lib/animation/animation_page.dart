import 'dart:math';

import 'package:flutter/material.dart';

class AnimationPage extends StatefulWidget {
  @override
  _AnimationPageState createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(),
        preferredSize: Size.fromHeight(44),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
        });
      },
      child: Center(
        child: Container(
          child: AnimatedContainer(
            duration: Duration(milliseconds: 1000),
            color: Colors.orangeAccent,
            width: _isSelected ? 400 : 300,
            height: _isSelected ? 300 : 250,
            // curve: Cubic(0.18, 1, 0.04, 0.1),
            curve: ShakeCurve(),
          ),
        ),
      ),
    );
  }
}

class ShakeCurve extends Curve {
  @override
  double transform(double t) {
    final v = sin(t * pi * 0.8);
    print('======transform==t: $t, v: $v');
    return v;
  }
}
