import 'package:flutter/material.dart';

class CubicHeartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CubicHeartPainter(),
    );
  }
}

class _CubicHeartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    _drawCubicHeart(canvas, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

// 使用贝塞尔曲线绘制心形
void _drawCubicHeart(Canvas canvas, Size size) {
  final mPath = new Path();
  final v = 396.0 - 200;
  final scale = 0.4;
  mPath.moveTo((v - 50.0) * scale, 313 * scale);
  mPath.cubicTo(
    (207 - 50.0 - 200) * scale,
    114 * scale,
    (339 - 50.0 - 200) * scale,
    46 * scale,
    (v - 50.0) * scale,
    111 * scale,
  );
  mPath.cubicTo(
    (453 - 50.0 - 200) * scale,
    46 * scale,
    (585 - 50.0 - 200) * scale,
    114 * scale,
    (v - 50.0) * scale,
    313 * scale,
  );

  final paint = Paint();
  paint..color = Colors.redAccent;
  canvas.drawPath(mPath, paint);
}
