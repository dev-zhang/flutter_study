import 'package:flutter/material.dart';

class CustomCardBorder extends ShapeBorder {
  @override
  EdgeInsetsGeometry get dimensions => null;

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) {
    return null;
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    final path = Path();

    // 左边一个正方形
    path.addRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(rect.left, rect.top, rect.height, rect.height),
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
        bottomLeft: Radius.circular(10),
      ),
    );
    // 右侧一个矩形
    path.addRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTRB(
            rect.left + rect.height, rect.top + 18, rect.right, rect.bottom),
        topRight: Radius.circular(10),
        bottomRight: Radius.circular(10),
      ),
    );

    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {}

  @override
  ShapeBorder scale(double t) {
    return null;
  }
}
