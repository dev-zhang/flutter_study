import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class HeartShape extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _HeartShapePainter(),
    );
  }
}

class _HeartShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    _drawCustomHeart(canvas, size);
  }

  // 使用几何图形绘制心形
  void _drawCustomHeart(Canvas canvas, Size size) {
    final paint = Paint();
    paint..color = Colors.redAccent;

    double maxRectH = size.width / 2.0 / cos(_getRad(41));
    maxRectH = min(maxRectH, size.height);
    final rectH = maxRectH;
    final rectW = rectH * 2 / 3;

    final path = Path();

    canvas.translate(size.width / 2.0, size.height);
    canvas.save();
    canvas.save();

    path.addRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(0, -rectH, rectW, rectH),
        topLeft: Radius.circular(rectW / 2.0),
        topRight: Radius.circular(rectW / 2.0),
      ),
    );
    canvas.rotate(-_getRad(49));
    canvas.drawPath(path, paint);
    canvas.restore();

    path.reset();
    path.addRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(-rectW, -rectH, rectW, rectH),
        topLeft: Radius.circular(rectW / 2.0),
        topRight: Radius.circular(rectW / 2.0),
      ),
    );
    canvas.rotate(_getRad(49));
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  double _getRad(double angle) {
    return pi / 180 * angle;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
