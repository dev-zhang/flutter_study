import 'dart:math';

import 'package:flutter/material.dart';

class CouponShapeBorder extends ShapeBorder {
  final int holeCount;
  final double lineRate;
  final bool dash;
  final Color color;

  CouponShapeBorder({
    this.holeCount = 6,
    this.lineRate = 0.718,
    this.dash = true,
    this.color = Colors.white,
  });

  @override
  EdgeInsetsGeometry get dimensions => null;

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) {
    return null;
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    final path = Path();

    final width = rect.width;
    final height = rect.height;
    final diameter = height / (1 + holeCount * 2);

    path.addRect(rect);

    _formHoleLeft(path, diameter);
    _formHoleRight(path, width, diameter);
    _formHoleTop(path, rect);
    _formHoleBottom(path, rect);

    path.fillType = PathFillType.evenOdd;

    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {
    final paint = Paint();
    paint
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round;

    // final diameter = rect.height / (1 + holeCount * 2);
    final diameter = 13;
    if (dash) {
      final count = 16;
      final step = (rect.height - diameter) / count / 2;
      for (int i = 0; i < count; i++) {
        final offset = Offset(lineRate * rect.width, diameter / 2) +
            Offset(0, step * 2 * i);
        canvas.drawLine(offset, offset + Offset(0, step), paint);
      }
    } else {
      canvas.drawLine(
        Offset(lineRate * rect.width, diameter / 2),
        Offset(lineRate * rect.width, rect.height - diameter / 2),
        paint,
      );
    }
  }

  @override
  ShapeBorder scale(double t) {
    return null;
  }

  void _formHoleLeft(Path path, double diameter) {
    for (int i = 0; i < holeCount; i++) {
      final left = -diameter / 2;
      final top = diameter + diameter * 2 * i;
      final right = left + diameter;
      final bottom = top + diameter;

      // 顺时针围绕，坐标系为顺时针为正角度，逆时针为负角度
      path.addArc(
        Rect.fromLTRB(left, top, right, bottom),
        -pi / 2,
        pi,
      );
    }
  }

  void _formHoleRight(Path path, double width, double diameter) {
    for (int i = 0; i < holeCount; i++) {
      final left = width - diameter / 2;
      final right = left + diameter;
      final top = diameter + diameter * 2 * i;
      final bottom = top + diameter;
      path.addArc(
        Rect.fromLTRB(left, top, right, bottom),
        pi / 2,
        pi,
      );
    }
  }

  void _formHoleTop(Path path, Rect rect) {
    path.addArc(
      Rect.fromCenter(
        center: Offset(lineRate * rect.width, 0),
        width: 13,
        height: 13,
      ),
      0,
      pi,
    );
  }

  void _formHoleBottom(Path path, Rect rect) {
    path.addArc(
      Rect.fromCenter(
        center: Offset(lineRate * rect.width, rect.height),
        width: 13,
        height: 13,
      ),
      pi,
      pi,
    );
  }
}
