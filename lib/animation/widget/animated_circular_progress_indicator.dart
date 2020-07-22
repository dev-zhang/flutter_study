import 'package:flutter/material.dart';
import 'dart:math' as math;

const double _kMinCircularProgressIndicatorSize = 36.0;

// Tweens used by circular progress indicator
final Animatable<double> _kStrokeHeadTween = CurveTween(
  curve: const Interval(0.0, 0.5, curve: Curves.fastOutSlowIn),
).chain(CurveTween(
  curve: const SawTooth(5),
));

final Animatable<double> _kStrokeTailTween = CurveTween(
  curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
).chain(CurveTween(
  curve: const SawTooth(5),
));

final Animatable<int> _kStepTween = StepTween(begin: 0, end: 5);

final Animatable<double> _kRotationTween = CurveTween(curve: const SawTooth(5));

class AnimatedCircularProgressIndicator extends ProgressIndicator {
  AnimatedCircularProgressIndicator({
    Key key,
    double value,
    Color backgroundColor,
    Animation<Color> valueColor,
    this.strokeWidth,
    @required this.duration,
    this.strokeCap,
    this.startAngle,
    String semanticsLabel,
    String semanticsValue,
  })  : assert(duration != null),
        super(
          key: key,
          value: value,
          backgroundColor: backgroundColor,
          valueColor: valueColor,
          semanticsLabel: semanticsLabel,
          semanticsValue: semanticsValue,
        );

  final double strokeWidth;

  /// 动画时长
  final Duration duration;

  final StrokeCap strokeCap;

  /// 起点的角度，默认为`-math.pi / 2.0`
  final double startAngle;

  @override
  _AnimatedCircularProgressIndicatorState createState() =>
      _AnimatedCircularProgressIndicatorState();
}

class _AnimatedCircularProgressIndicatorState
    extends State<AnimatedCircularProgressIndicator>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  AnimationController _controller;

  Animation<double> _progressAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    if (widget.value != null) {
      _progressAnimation =
          Tween<double>(begin: widget.value).animate(_animationController);
    }

    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );
    if (widget.value == null) _controller.repeat();

    super.initState();
  }

  @override
  void didUpdateWidget(AnimatedCircularProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);

    // 处理widget.value == null or oldWidget.value == null 的情况
    if (widget.value != oldWidget.value && widget.value != null) {
      // update
      double oldValue = oldWidget.value ?? 0;
      double bouncingValue = widget.value *
          (1 +
              (10 / 100) *
                  (widget.value - oldValue) /
                  (widget.value - oldValue).abs());
      bouncingValue = bouncingValue.clamp(0, 1).toDouble();
      _progressAnimation = TweenSequence(
        <TweenSequenceItem<double>>[
          TweenSequenceItem(
            tween: Tween(
              begin: oldValue,
              end: bouncingValue,
            ).chain(CurveTween(curve: Curves.ease)),
            weight: 3 / 4,
          ),
          TweenSequenceItem(
            tween: Tween(begin: bouncingValue, end: widget.value)
                .chain(CurveTween(curve: Curves.ease)),
            weight: 1 / 4,
          ),
        ],
      ).animate(_animationController);
      _animationController.forward(from: 0);
    }

    if (widget.value == null && !_controller.isAnimating)
      _controller.repeat();
    else if (widget.value != null && _controller.isAnimating)
      _controller.stop();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.value != null) {
      return AnimatedBuilder(
        animation: _progressAnimation,
        builder: (BuildContext context, Widget child) {
          return _buildIndicator(
            context,
            0,
            0,
            0,
            0,
            value: _progressAnimation.value,
          );
        },
      );
    } else {
      return _buildAnimation();
    }
  }

  Widget _buildIndicator(BuildContext context, double headValue,
      double tailValue, int stepValue, double rotationValue,
      {double value}) {
    String expandedSemanticsValue = widget.semanticsValue;
    if (widget.value != null) {
      expandedSemanticsValue ??= '${(widget.value * 100).round()}%';
    }
    return Semantics(
      label: widget.semanticsLabel,
      value: expandedSemanticsValue,
      child: Container(
        constraints: const BoxConstraints(
          minWidth: _kMinCircularProgressIndicatorSize,
          minHeight: _kMinCircularProgressIndicatorSize,
        ),
        child: CustomPaint(
          painter: _CircularProgressIndicatorPainter(
            backgroundColor: widget.backgroundColor,
            valueColor:
                widget.valueColor?.value ?? Theme.of(context).accentColor,
            value: value, // may be null
            headValue:
                headValue, // remaining arguments are ignored if widget.value is not null
            tailValue: tailValue,
            stepValue: stepValue,
            rotationValue: rotationValue,
            strokeWidth: widget.strokeWidth,
            strokeCap: widget.strokeCap,
            startAngle: widget.startAngle,
          ),
        ),
      ),
    );
  }

  Widget _buildAnimation() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget child) {
        return _buildIndicator(
          context,
          _kStrokeHeadTween.evaluate(_controller),
          _kStrokeTailTween.evaluate(_controller),
          _kStepTween.evaluate(_controller),
          _kRotationTween.evaluate(_controller),
        );
      },
    );
  }
}

class _CircularProgressIndicatorPainter extends CustomPainter {
  _CircularProgressIndicatorPainter({
    this.backgroundColor,
    this.valueColor,
    this.value,
    this.headValue,
    this.tailValue,
    this.stepValue,
    this.rotationValue,
    this.strokeWidth,
    this.strokeCap,
    double startAngle,
  })  : arcStart = value != null
            ? (startAngle ?? _startAngle)
            : (startAngle ?? _startAngle) +
                tailValue * 3 / 2 * math.pi +
                rotationValue * math.pi * 1.7 -
                stepValue * 0.8 * math.pi,
        arcSweep = value != null
            ? value.clamp(0.0, 1.0) * _sweep
            : math.max(
                headValue * 3 / 2 * math.pi - tailValue * 3 / 2 * math.pi,
                _epsilon);

  final Color backgroundColor;
  final Color valueColor;
  final double value;
  final double headValue;
  final double tailValue;
  final int stepValue;
  final double rotationValue;
  final double strokeWidth;
  final double arcStart;
  final double arcSweep;

  final StrokeCap strokeCap;

  static const double _twoPi = math.pi * 2.0;
  static const double _epsilon = .001;
  // Canvas.drawArc(r, 0, 2*PI) doesn't draw anything, so just get close.
  static const double _sweep = _twoPi - _epsilon;
  static const double _startAngle = -math.pi / 2.0;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect innerRect = Rect.fromCenter(
      center: size.center(Offset.zero),
      width: size.width - strokeWidth,
      height: size.height - strokeWidth,
    );

    final Paint paint = Paint()
      ..color = valueColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    if (backgroundColor != null) {
      final Paint backgroundPaint = Paint()
        ..color = backgroundColor
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke;
      canvas.drawArc(innerRect, 0, _sweep, false, backgroundPaint);
    }

    if (value == null) // Indeterminate
      paint.strokeCap = StrokeCap.square;

    if (strokeCap != null) {
      // 端点点形状
      paint.strokeCap = strokeCap;
    }

    canvas.drawArc(innerRect, arcStart, arcSweep, false, paint);
  }

  @override
  bool shouldRepaint(_CircularProgressIndicatorPainter oldPainter) {
    return oldPainter.backgroundColor != backgroundColor ||
        oldPainter.valueColor != valueColor ||
        oldPainter.value != value ||
        oldPainter.headValue != headValue ||
        oldPainter.tailValue != tailValue ||
        oldPainter.stepValue != stepValue ||
        oldPainter.rotationValue != rotationValue ||
        oldPainter.strokeWidth != strokeWidth ||
        oldPainter.strokeCap != strokeCap;
  }
}
