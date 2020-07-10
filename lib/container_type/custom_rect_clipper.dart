import 'package:flutter/material.dart';

class CustomRectClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    final newSize = Size(size.width - 30, size.height - 45);
    final rect = Rect.fromCenter(
      center: size.center(Offset.zero),
      width: newSize.width,
      height: newSize.height,
    );
    return rect;
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    if (oldClipper.runtimeType != this.runtimeType) {
      return true;
    }
    return false;
  }
}
