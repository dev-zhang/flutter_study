import 'package:flutter/material.dart';

class CustomPathClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    // 添加一个圆形路径
    path.addOval(
        Rect.fromCircle(center: size.center(Offset.zero), radius: 100));
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    if (oldClipper.runtimeType != this.runtimeType) {
      return true;
    }
    return false;
  }
}
