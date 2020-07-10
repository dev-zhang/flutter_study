import 'package:flutter/material.dart';
import 'package:flutter_study/constant/constant.dart';

class AnimationControllerPage extends StatefulWidget {
  @override
  _AnimationControllerPageState createState() =>
      _AnimationControllerPageState();
}

class _AnimationControllerPageState extends State<AnimationControllerPage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  Animation<Color> _colorAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000),
    );

    _colorAnimation =
        ColorTween(begin: Colors.orangeAccent, end: Colors.deepOrangeAccent)
            .animate(
      CurvedAnimation(parent: _animationController, curve: Curves.linear),
    );

    _animationController.addListener(() {
      setState(() {});
    });

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
        child: AppBar(title: Text('Animation,AnimationController')),
        preferredSize: Size.fromHeight(kAppBarHeight),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          IconButton(
            color: Colors.orangeAccent,
            iconSize: 80,
            icon: Icon(Icons.autorenew),
            onPressed: () {
              if (_animationController?.isAnimating ?? false) {
                _animationController.stop();
              } else {
                _animationController.repeat(reverse: true);
              }
            },
          ),
          Container(
            margin: EdgeInsets.all(20),
            width:
                MediaQuery.of(context).size.width * _animationController.value,
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                color: Colors.blueAccent,
              ),
            ),
          ),
          SizedBox.fromSize(
            size: Size(MediaQuery.of(context).size.width * 0.6, 200),
            child: Container(
              color: _colorAnimation.value,
            ),
          ),
        ],
      ),
    );
  }
}
