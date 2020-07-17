import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AnimatedFavoriteIcon extends StatefulWidget {
  const AnimatedFavoriteIcon({
    Key key,
    this.selected = false,
  }) : super(key: key);

  /// 是否是选中的
  final bool selected;

  @override
  _AnimatedFavoriteIconState createState() => _AnimatedFavoriteIconState();
}

class _AnimatedFavoriteIconState extends State<AnimatedFavoriteIcon>
    with SingleTickerProviderStateMixin {
  bool get _isSelected => widget.selected;

  AnimationController _animationController;
  Animation<double> _selectedIconScale;
  Animation<double> _selectedIconOpacity;
  Animation<double> _normalIconScale;
  Animation<double> _normalIconOpacity;
  Animation<double> _starScale;
  Animation<double> _starOpacity;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));

    double selectedIconScale,
        selectedIconOpacity,
        normalIconScale,
        normalIconOpacity,
        starScale,
        starOpacity;
    if (_isSelected) {
      selectedIconOpacity = 1;
      selectedIconScale = 1;
      normalIconOpacity = 0;
      normalIconScale = 0;
      starOpacity = 0;
      starScale = 0;
    } else {
      selectedIconOpacity = 0;
      selectedIconScale = 0;
      normalIconOpacity = 1;
      normalIconScale = 1;
      starOpacity = 0;
      starScale = 0;
    }
    _normalIconScale =
        ConstantTween<double>(normalIconScale).animate(_animationController);
    _normalIconOpacity =
        ConstantTween<double>(normalIconOpacity).animate(_animationController);
    _selectedIconScale =
        ConstantTween<double>(selectedIconScale).animate(_animationController);
    _selectedIconOpacity = ConstantTween<double>(selectedIconOpacity)
        .animate(_animationController);
    _starOpacity =
        ConstantTween<double>(starOpacity).animate(_animationController);
    _starScale = ConstantTween<double>(starScale).animate(_animationController);

    super.initState();
  }

  @override
  void didUpdateWidget(AnimatedFavoriteIcon oldWidget) {
    super.didUpdateWidget(oldWidget);

    // print('======didUpdate widget');
    if (widget.selected != oldWidget.selected) {
      // 需要刷新
      _updateTransition();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        FadeTransition(
          opacity: _starOpacity,
          child: ScaleTransition(
            scale: _starScale,
            child: SvgPicture.asset('assets/svgs/favorite_stars.svg'),
          ),
        ),
        FadeTransition(
          opacity: _selectedIconOpacity,
          child: ScaleTransition(
            scale: _selectedIconScale,
            child: SvgPicture.asset('assets/svgs/favorite_selected.svg'),
          ),
        ),
        FadeTransition(
          opacity: _normalIconOpacity,
          child: ScaleTransition(
            scale: _normalIconScale,
            child: SvgPicture.asset('assets/svgs/favorite_normal.svg'),
          ),
        ),
      ],
    );
  }

  void _updateTransition() {
    if (_isSelected) {
      _animationController.duration = Duration(milliseconds: 600);
      _selectedIconScale = _generateSelectedGrowAnimation();
      _normalIconScale = _generateDecreaseAnimation(
          interval: Interval(0, 0.3, curve: Curves.easeOut));
      _starScale = TweenSequence(
        <TweenSequenceItem<double>>[
          TweenSequenceItem(
            tween: Tween<double>(begin: 0, end: 1.0)
                .chain(CurveTween(curve: Curves.easeIn)),
            weight: 0.3 / 0.6,
          ),
          TweenSequenceItem(
            tween: Tween<double>(begin: 1.0, end: 1.2)
                .chain(CurveTween(curve: Curves.easeOut)),
            weight: 0.3 / 0.6,
          ),
        ],
      ).animate(_animationController);
      _starOpacity = TweenSequence(
        <TweenSequenceItem<double>>[
          TweenSequenceItem(
            tween: Tween<double>(begin: 0, end: 1.0)
                .chain(CurveTween(curve: Curves.easeIn)),
            weight: 0.3 / 0.6,
          ),
          TweenSequenceItem(
            tween: Tween<double>(begin: 1.0, end: 0)
                .chain(CurveTween(curve: Curves.easeOut)),
            weight: 0.3 / 0.6,
          ),
        ],
      ).animate(_animationController);
      _selectedIconOpacity = TweenSequence(
        <TweenSequenceItem<double>>[
          TweenSequenceItem(
            tween: Tween<double>(begin: 0, end: 1.5)
                .chain(CurveTween(curve: Curves.easeIn)),
            weight: 0.3 / 0.6,
          ),
          TweenSequenceItem(
            tween: Tween<double>(begin: 1.5, end: 1)
                .chain(CurveTween(curve: Curves.easeOut)),
            weight: 0.3 / 0.6,
          ),
        ],
      ).animate(_animationController);
      _normalIconOpacity = _generateDecreaseAnimation(
          interval: Interval(0, 0.3, curve: Curves.easeOut));
    } else {
      _animationController.duration = Duration(milliseconds: 300);
      _selectedIconScale = _generateDecreaseAnimation();
      _normalIconScale = _generateGrowAnimation();

      _starOpacity = ConstantTween<double>(0).animate(_animationController);
      _starScale = ConstantTween<double>(0).animate(_animationController);
      _normalIconOpacity = _generateGrowAnimation();
      _selectedIconOpacity = _generateDecreaseAnimation();
    }
    _animationController.forward(from: 0);
  }

  Animation<double> _generateSelectedGrowAnimation() {
    return TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem(
          tween: Tween<double>(begin: 0, end: 1.5)
              .chain(CurveTween(curve: Curves.easeIn)),
          weight: 0.3 / 0.6,
        ),
        TweenSequenceItem(
          tween: Tween<double>(begin: 1.5, end: 1)
              .chain(CurveTween(curve: Curves.easeOut)),
          weight: 0.3 / 0.6,
        ),
      ],
    ).animate(_animationController);
  }

  Animation<double> _generateDecreaseAnimation({Interval interval}) {
    Curve curve;
    if (interval == null) {
      curve = Curves.easeOut;
    } else {
      curve = interval;
    }
    return Tween<double>(begin: 1.0, end: 0).animate(
      CurvedAnimation(parent: _animationController, curve: curve),
    );
  }

  Animation<double> _generateGrowAnimation() {
    return Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );
  }
}
