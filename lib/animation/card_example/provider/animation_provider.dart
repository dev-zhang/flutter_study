import 'package:flutter/material.dart';

const int _kDuration = 200;

// ignore: must_be_immutable
class AnimationProvider extends State<StatefulWidget>
    with ChangeNotifier, SingleTickerProviderStateMixin {
  AnimationProvider() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _kDuration),
    );
    _animationController.addStatusListener(_animationControllerStatusListener);
    _curvedAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
      reverseCurve: Curves.easeOut,
    );

    _updateInitialAnimation();
  }

  AnimationController get animationController => _animationController;

  Animation<double> scaleAnimation(int index) =>
      isSelected(index) ? _selectedScale : _normalScale;
  Animation<Decoration> decorationAnimation(int index) =>
      isSelected(index) ? _selectedDecoration : _normalDecoration;
  Animation<double> get answerResultScale => _answerResultScale;
  Animation<double> get answerResultOpacity => _answerResultOpacity;
  Animation<double> get answerEvaluationScale => _answerEvaluationScale;
  Animation<double> get answerEvaluationOpacity => _answerEvaluationOpacity;
  Animation<Offset> get answerEvaluationOffset => _answerEvaluationOffset;
  Animation<double> get shineScale => _shineScale;
  Animation<double> get shineOpacity => _shineOpacity;
  Animation<Offset> get shineOffset => _shineOffset;

  AnimationController _animationController;
  CurvedAnimation _curvedAnimation;

  Animation<double> _selectedScale;
  Animation<double> _normalScale;
  Animation<Decoration> _selectedDecoration;
  Animation<Decoration> _normalDecoration;

  // 作答结果的动画 (对号 or 叉叉)
  Animation<double> _answerResultScale;
  Animation<double> _answerResultOpacity;

  // 作答结果评价的动画（perfect……）
  Animation<double> _answerEvaluationScale;
  Animation<double> _answerEvaluationOpacity;
  Animation<Offset> _answerEvaluationOffset;

  // 评价发光组件的动画
  Animation<double> _shineScale;
  Animation<double> _shineOpacity;
  Animation<Offset> _shineOffset;

  // 当前选中的下标
  int _selectedIndex;
  bool isSelected(int index) => index == _selectedIndex;

  // 是否正在按压
  bool _isTapping = false;

  Future<void> onTapItem(int index) async {
    // 如果正向动画执行完毕？=> 执行新的交织动画
    // 否则等待正向动画执行完毕，然后执行新的交织动画
    _isTapping = false;
    if (_animationController.status == AnimationStatus.completed) {
      // _animationController.reverse();
      _updateTapUpAnimation();
      _animationController.forward(from: 0);
    }
  }

  Future<void> onTapDownItem(int index) async {
    _selectedIndex = index;
    _isTapping = true;
    notifyListeners();
    // FIXME: 后续动画还未完成，先在此处做重置操作
    _updateInitialAnimation();

    _animationController.forward(from: 0);
  }

  // 更新初始状态animation
  void _updateInitialAnimation() {
    _animationController.duration = Duration(milliseconds: _kDuration);
    _selectedScale =
        Tween<double>(begin: 1, end: 0.94).animate(_curvedAnimation);
    _selectedDecoration = DecorationTween(
      begin: BoxDecoration(color: Colors.black.withOpacity(0)),
      end: BoxDecoration(color: Colors.black.withOpacity(0.6)),
    ).animate(_curvedAnimation);

    _normalScale = ConstantTween(1.0).animate(_curvedAnimation);
    _normalDecoration = ConstantTween(BoxDecoration(
      color: Colors.white.withOpacity(0),
    )).animate(_curvedAnimation);

    _answerResultScale = ConstantTween<double>(0).animate(_curvedAnimation);
    _answerResultOpacity = ConstantTween<double>(0).animate(_curvedAnimation);

    _answerEvaluationScale = ConstantTween<double>(0).animate(_curvedAnimation);
    _answerEvaluationOpacity =
        ConstantTween<double>(0).animate(_curvedAnimation);
    _answerEvaluationOffset =
        ConstantTween<Offset>(Offset.zero).animate(_curvedAnimation);

    _shineScale = ConstantTween<double>(0).animate(_animationController);
    _shineOpacity = ConstantTween(0.0).animate(_animationController);
    _shineOffset = ConstantTween(Offset.zero).animate(_animationController);

    notifyListeners();
  }

  // 更新手指抬起后的animation
  void _updateTapUpAnimation() {
    double t = 1.2 - 0.2;
    _animationController.duration = Duration(milliseconds: (t * 1000).toInt());
    _selectedScale = Tween<double>(begin: 0.94, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0, 0.2 / t, curve: Curves.easeOut),
      ),
    );
    _selectedDecoration = DecorationTween(
      begin: BoxDecoration(color: Colors.black.withOpacity(0.6)),
      end: BoxDecoration(color: Colors.black.withOpacity(0.0)),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.0, 0.2 / t, curve: Curves.easeOut),
      ),
    );
    _normalDecoration = DecorationTween(
      begin: BoxDecoration(color: Colors.white.withOpacity(0.0)),
      end: BoxDecoration(color: Colors.white.withOpacity(0.6)),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.1 / t, (0.6 - 0.2) / t, curve: Curves.easeIn),
      ),
    );

    _answerResultScale = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.1 / t, (0.6 - 0.2) / t, curve: Curves.easeIn),
      ),
    );
    _answerResultOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.1 / t, (0.6 - 0.2) / t, curve: Curves.easeIn),
      ),
    );

    _answerEvaluationScale = TweenSequence<double>(
      <TweenSequenceItem<double>>[
        TweenSequenceItem(
          tween: ConstantTween<double>(0),
          weight: 0.2 / t,
        ),
        TweenSequenceItem(
          tween: Tween<double>(begin: 0, end: 1)
              .chain(CurveTween(curve: Curves.easeIn)),
          weight: 0.3 / t,
        ),
        TweenSequenceItem(
          tween: Tween<double>(begin: 1, end: 1.25)
              .chain(CurveTween(curve: Curves.easeInOut)),
          weight: 0.15 / t,
        ),
        TweenSequenceItem(
          tween: Tween<double>(begin: 1.25, end: 1)
              .chain(CurveTween(curve: Curves.easeInOut)),
          weight: 0.15 / t,
        ),
        TweenSequenceItem(
          tween: ConstantTween<double>(1),
          weight: 0.2 / t,
        ),
      ],
    ).animate(_animationController);
    _answerEvaluationOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.2 / t, 0.5 / t, curve: Curves.easeIn),
      ),
    );
    _answerEvaluationOffset =
        Tween<Offset>(begin: Offset(0, 800 / 560), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.2 / t, 0.5 / t, curve: Curves.easeIn),
      ),
    );

    _shineScale = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.65 / t, 0.8 / t, curve: Curves.easeIn),
      ),
    );
    _shineOpacity = TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem(tween: ConstantTween(0.0), weight: 0.65),
        TweenSequenceItem(
          tween: Tween(begin: 0.0, end: 1.0)
              .chain(CurveTween(curve: Curves.easeIn)),
          weight: 0.15,
        ),
        TweenSequenceItem(
          tween: Tween(begin: 1.0, end: 0.0)
              .chain(CurveTween(curve: Curves.easeOut)),
          weight: 0.2,
        ),
      ],
    ).animate(_animationController);
    _shineOffset = TweenSequence(
      <TweenSequenceItem<Offset>>[
        TweenSequenceItem(tween: ConstantTween(Offset.zero), weight: 0.65),
        TweenSequenceItem(
          tween: Tween(
            begin: Offset.zero,
            end: Offset(3 / 154, -6 / 56),
          ).chain(CurveTween(curve: Curves.easeIn)),
          weight: 0.15,
        ),
        TweenSequenceItem(
          tween: Tween(
            begin: Offset(3 / 154, -6 / 56),
            end: Offset.zero,
          ).chain(CurveTween(curve: Curves.easeOut)),
          weight: 0.2,
        ),
      ],
    ).animate(_animationController);

    notifyListeners();
  }

  void _animationControllerStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed && _isTapping == false) {
      // _animationController.reverse();
      _updateTapUpAnimation();

      _animationController.forward(from: 0);
      _isTapping = null;
    }
  }

  @override
  void dispose() {
    _animationController
        .removeStatusListener(_animationControllerStatusListener);
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return null;
  }
}
