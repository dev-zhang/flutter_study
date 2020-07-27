import 'package:flutter/material.dart';
import 'package:flutter_study/constant/constant.dart';

import 'widget/animated_favorite_icon.dart';

class StaggerAnimationPage extends StatefulWidget {
  @override
  _StaggerAnimationPageState createState() => _StaggerAnimationPageState();
}

class _StaggerAnimationPageState extends State<StaggerAnimationPage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  // 是否已收藏
  bool _isFavorited = false;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _animationController.repeat(reverse: true);

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(title: Text('交织动画')),
        preferredSize: Size.fromHeight(kAppBarHeight),
      ),
      body: _buildBody(context),
    );
  }

  Future<void> _playOrStopAnimation() async {
    try {
      await _animationController.forward().orCancel;
      await _animationController.reverse().orCancel;
    } on TickerCanceled {
      print('=====animation canceled');
    }
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: _playOrStopAnimation,
          child: Center(
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.orange[50],
                border: Border.all(),
              ),
              child: ZYAnimatedContainer(
                animationController: _animationController,
              ),
            ),
          ),
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 20)),
        _buildCustomFavoriteButton(context),
      ],
    );
  }

  Widget _buildCustomFavoriteButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: FlatButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onPressed: () {
          setState(() {
            _isFavorited = !_isFavorited;
          });
        },
        child: AnimatedFavoriteIcon(
          selected: _isFavorited,
        ),
      ),
    );
  }
}

class ZYAnimatedContainer extends StatefulWidget {
  final AnimationController animationController;

  const ZYAnimatedContainer({
    Key key,
    @required this.animationController,
  })  : assert(animationController != null),
        super(key: key);

  @override
  _ZYAnimatedContainerState createState() => _ZYAnimatedContainerState();
}

class _ZYAnimatedContainerState extends State<ZYAnimatedContainer> {
  AnimationController get _animationController => widget.animationController;

  Animation<double> _height;
  Animation<Color> _color;
  Animation<EdgeInsets> _padding;

  @override
  void initState() {
    _height = Tween<double>(begin: 0, end: 300).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0, 0.6, curve: Curves.easeInOut),
      ),
    );
    _color =
        ColorTween(begin: Colors.orangeAccent, end: Colors.blueAccent).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0, 0.6, curve: Curves.easeInOut),
      ),
    );
    _padding =
        EdgeInsetsTween(begin: EdgeInsets.zero, end: EdgeInsets.only(left: 90))
            .animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.6, 1, curve: Curves.easeInOut),
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget child) {
        return Container(
          alignment: Alignment.bottomLeft,
          padding: _padding.value,
          child: Container(
            width: 60,
            height: _height.value,
            color: _color.value,
          ),
        );
      },
    );
  }
}
