import 'package:flutter/material.dart';

class CustomCircleShape extends ShapeBorder {
  @override
  EdgeInsetsGeometry get dimensions => null;

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) {
    return null;
  }

  /// 返回一个Path对象，用于形状的裁剪
  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    return null;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {
    final paint = Paint();
    paint
      ..color = Colors.white
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round;
    final width = rect.width;
    final height = rect.height;
    canvas.drawCircle(
        Offset(width * 0.12, height * 0.35), rect.shortestSide * 0.22, paint);

    paint
      ..style = PaintingStyle.fill
      ..color = Colors.blueAccent;
    canvas.drawCircle(
        Offset(width * 0.12, height * 0.35), rect.shortestSide * 0.1, paint);
  }

  @override
  ShapeBorder scale(double t) {
    return null;
  }
}
