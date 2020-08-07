import 'package:flutter/material.dart';

class CoordinateSystemWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CoordinateSystemPainter(),
    );
  }
}

class _CoordinateSystemPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final int step = 20;
    final path = Path();
    // 添加横线
    for (int i = 0; i < h / step + 1; i++) {
      path.moveTo(0, step * i.toDouble());
      path.lineTo(w, step * i.toDouble());
    }
    // 添加竖线
    for (int i = 0; i < w / step + 1; i++) {
      path.moveTo(step * i.toDouble(), 0);
      path.lineTo(step * i.toDouble(), h);
    }

    final paint = Paint();
    paint
      ..color = Color(0xff83a0ae)
      ..style = PaintingStyle.stroke;

    canvas.drawPath(path, paint);

    final Path coordinatePath = Path();
    final xAxisLength = w / 2.0;
    final yAxisLength = h / 2.0;
    // path.moveTo(xAxisLength, yAxisLength);
    // path.lineTo(w, yAxisLength);
    coordinatePath.moveTo(0, yAxisLength);
    coordinatePath.lineTo(w, yAxisLength);
    coordinatePath.moveTo(xAxisLength, 0);
    coordinatePath.lineTo(xAxisLength, h);
    // 右边箭头
    coordinatePath.moveTo(w, yAxisLength);
    coordinatePath.lineTo(w - 10, yAxisLength - 6);
    coordinatePath.moveTo(w, yAxisLength);
    coordinatePath.lineTo(w - 10, yAxisLength + 6);
    // 上方箭头
    coordinatePath.moveTo(xAxisLength, 0);
    coordinatePath.lineTo(xAxisLength - 6, 10);
    coordinatePath.moveTo(xAxisLength, 0);
    coordinatePath.lineTo(xAxisLength + 6, 10);

    paint
      ..color = Colors.black
      ..strokeWidth = 2;
    canvas.drawPath(coordinatePath, paint);
  }

  @override
  bool shouldRepaint(_CoordinateSystemPainter oldDelegate) {
    return oldDelegate != this;
  }
}
