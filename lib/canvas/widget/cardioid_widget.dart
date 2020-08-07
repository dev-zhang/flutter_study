import 'dart:math';

import 'package:flutter/material.dart';

class CardioidWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CardioidPainter(),
    );
  }
}

class _CardioidPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    _drawCardioid(canvas, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

// 心脏线
void _drawCardioid(Canvas canvas, Size size) {
  final a = 50.0;
  var t = 0.0;
  var maxT = pi * 2;
  var vt = 0.01;
  final maxI = (maxT / vt).ceil();
  final arr = <Offset>[];
  var x = 0.0;
  var y = 0.0;
  for (var i = 0; i <= maxI; i++) {
    x = a * (2 * sin(t) + sin(2 * t));
    y = a * (2 * cos(t) + cos(2 * t));
    t += vt;
    arr.add(Offset(x, y));
  }
  final path = Path();
  path.moveTo(arr.first.dx, arr.first.dy);
  for (var offset in arr) {
    path.lineTo(offset.dx, offset.dy);
  }
  final paint = Paint();
  paint
    ..color = Colors.redAccent
    ..style = PaintingStyle.fill
    ..strokeWidth = 5;
  canvas.translate(size.width / 2.0, size.height / 2.0);
  canvas.drawPath(path, paint);
}
