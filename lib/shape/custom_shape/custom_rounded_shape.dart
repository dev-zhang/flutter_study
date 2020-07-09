import 'package:flutter/material.dart';

class CustomRoundedShape extends ShapeBorder {
  @override
  EdgeInsetsGeometry get dimensions => null;

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) {
    return null;
  }

  /// 返回一个Path对象，用于形状的裁剪
  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    final path = Path();

    // addRRect添加一个圆角矩形
    path.addRRect(
      RRect.fromRectAndRadius(rect, Radius.circular(10)),
    );

    // 再添加一个圆形，然后两个路径叠加，使用**奇偶环绕**来处理路径
    final width = rect.width;
    final height = rect.height;
    final radius = height * 0.2;
    final diameter = radius * 2;
    final padding = height * 0.1;
    final left = width - diameter - padding;
    final top = padding;
    final right = left + diameter;
    final bottom = top + diameter;
    path.addOval(Rect.fromLTRB(left, top, right, bottom));
    // path.addOval(
    //   Rect.fromCircle(
    //     radius: radius,
    //     center: Offset(left, top + radius),
    //   ),
    // );

    // 使用**奇偶环绕**方式
    path.fillType = PathFillType.evenOdd;

    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {}

  @override
  ShapeBorder scale(double t) {
    return null;
  }
}
