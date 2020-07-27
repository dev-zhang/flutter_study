import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_study/animation/widget/progressive_number.dart';
import 'package:flutter_study/constant/constant.dart';

class RollingNumberExamplePage extends StatefulWidget {
  @override
  _RollingNumberExamplePageState createState() =>
      _RollingNumberExamplePageState();
}

class _RollingNumberExamplePageState extends State<RollingNumberExamplePage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  int _count = 0;
  int _newCount;
  Animation<int> _newNumberAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    _newNumberAnimation = ConstantTween(_count).animate(_animationController);

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
        child: AppBar(title: Text('滚动的数字')),
        preferredSize: Size.fromHeight(kAppBarHeight),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FlatButton(
            onPressed: () {
              _newCount = Random().nextInt(_count + 100);
              _newNumberAnimation =
                  IntTween(begin: _count, end: _newCount).animate(
                CurvedAnimation(
                  parent: _animationController,
                  curve: Curves.decelerate,
                ),
              );
              int milliseconds = 600;
              if ((_newCount - _count).abs() <= 10) {
                milliseconds = 300;
              }
              _animationController.duration =
                  Duration(milliseconds: milliseconds);
              _animationController.forward(from: 0);
              setState(() {
                _count = _newCount;
              });
            },
            child: Icon(
              Icons.refresh,
              size: 80,
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 20)),
          AnimatedBuilder(
            animation: _newNumberAnimation,
            builder: (BuildContext context, Widget child) {
              return AnimatedSwitcher(
                duration: Duration(milliseconds: 30),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(
                    scale:
                        Tween<double>(begin: 0.98, end: 1).animate(animation),
                    child: child,
                  );
                },
                layoutBuilder:
                    (Widget currentChild, List<Widget> previousChildren) {
                  return currentChild;
                },
                child: Text(
                  '${_newNumberAnimation.value}',
                  key: ValueKey(_newNumberAnimation.value),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 38,
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 20),
          ProgressiveNumber(
            _count,
            builder: (_, count) {
              return Text(
                '$count',
                style: TextStyle(
                  fontSize: 38,
                ),
              );
            },
          ),
          DefaultTextStyle(
            style: TextStyle(
              fontSize: 38,
              color: Colors.black,
            ),
            child: ProgressiveNumber(
              _count,
            ),
          ),
        ],
      ),
    );
  }
}
