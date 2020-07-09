import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HoleShapeBorder extends ShapeBorder {
  final Offset offset;
  // final double radius;
  final int count;

  HoleShapeBorder({
    this.offset = const Offset(0.1, 0.1),
    // this.radius = 20,
    this.count = 1,
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
    path.addRRect(
      RRect.fromRectAndRadius(rect, Radius.circular(10)),
    );

    final width = rect.width;
    final height = rect.height;
    final diameter =
        min(rect.shortestSide - offset.dy * height * 2, width / (count + 1));

    for (int i = 0; i < count; i++) {
      final offsetXY = Offset(
        diameter / (count + 1) * (i + 1) + diameter * i,
        offset.dy * height,
      );

      path.addOval(_getOvalRect(diameter, offsetXY));
    }

    path.fillType = PathFillType.evenOdd;

    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {}

  @override
  ShapeBorder scale(double t) {
    return null;
  }

  Rect _getOvalRect(double diameter, Offset offset) {
    final left = offset.dx;
    final right = left + diameter;
    final top = offset.dy;
    final bottom = top + diameter;
    return Rect.fromLTRB(left, top, right, bottom);
  }
}
