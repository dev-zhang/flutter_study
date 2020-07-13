import 'package:flutter/material.dart';
import 'package:flutter_study/constant/constant.dart';

class AnimatedWidgetPage extends StatefulWidget {
  @override
  _AnimatedWidgetPageState createState() => _AnimatedWidgetPageState();
}

class _AnimatedWidgetPageState extends State<AnimatedWidgetPage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000),
    );
    _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(title: Text('AnimatedWidget示例')),
        preferredSize: Size.fromHeight(kAppBarHeight),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          AnimatedImage(
            animation: _animationController,
          ),
          GrowTransition(
            child: Image.asset('assets/images/uzumaki_naruto-011.jpg'),
            animation: _animationController,
          )
        ],
      ),
    );
  }
}

class AnimatedImage extends AnimatedWidget {
  const AnimatedImage({
    Key key,
    Animation<double> animation,
  }) : super(key: key, listenable: animation);

  Animation<double> get _scale => listenable;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/uzumaki_naruto-011.jpg',
      width: MediaQuery.of(context).size.width * _scale.value,
      height: MediaQuery.of(context).size.width * _scale.value,
    );
  }
}

class GrowTransition extends AnimatedWidget {
  const GrowTransition({
    Key key,
    @required this.child,
    @required Animation<double> animation,
  })  : assert(child != null),
        assert(animation != null),
        super(key: key, listenable: animation);

  final Widget child;

  Animation<double> get sizeFactor => listenable;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Align(
        child: child,
        widthFactor: sizeFactor.value,
        heightFactor: sizeFactor.value,
      ),
    );
  }
}
