import 'package:flutter/material.dart';

/// 渐进（递增/递减）变化的数字
///
class ProgressiveNumber<T extends num> extends StatefulWidget {
  const ProgressiveNumber(
    this.number, {
    Key key,
    this.builder,
    this.curve = Curves.decelerate,
    this.duration,
  })  : assert(number != null),
        assert(curve != null),
        super(key: key);

  final T number;

  /// 为空时会根据新旧值的跨度区间计算，跨度大于10：600ms，小于等于10：300ms
  final Duration duration;
  final Curve curve;
  final Widget Function(BuildContext context, T number) builder;

  @override
  _ProgressiveNumberState createState() => _ProgressiveNumberState<T>();
}

const Duration _kAnimationDuration = Duration(milliseconds: 600);

class _ProgressiveNumberState<T extends num> extends State<ProgressiveNumber>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<num> _animation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration ?? _kAnimationDuration,
    );
    _animation = AlwaysStoppedAnimation(widget.number);

    super.initState();
  }

  @override
  void didUpdateWidget(ProgressiveNumber oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.number != widget.number) {
      if (T == int) {
        _animation =
            IntTween(begin: oldWidget.number, end: widget.number).animate(
          CurvedAnimation(parent: _animationController, curve: widget.curve),
        );
      } else {
        _animation =
            Tween<T>(begin: oldWidget.number, end: widget.number).animate(
          CurvedAnimation(parent: _animationController, curve: widget.curve),
        );
      }

      if (widget.duration != null) {
        _animationController.duration = widget.duration;
      } else {
        int milliseconds = 600;
        if ((widget.number - oldWidget.number).abs() <= 10) {
          milliseconds = 300;
        }
        _animationController.duration = Duration(milliseconds: milliseconds);
      }

      _animationController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget child) {
        Widget text;
        if (widget.builder != null) {
          text = widget.builder(context, _animation.value);
        }
        if (text == null) {
          text = Text(_animation.value.toString());
        }
        return text;
      },
    );
  }
}
