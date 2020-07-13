import 'package:flutter/material.dart';
import 'package:flutter_study/constant/constant.dart';

class AnimatedBuilderPage extends StatefulWidget {
  @override
  _AnimatedBuilderPageState createState() => _AnimatedBuilderPageState();
}

class _AnimatedBuilderPageState extends State<AnimatedBuilderPage>
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
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(title: Text('AnimatedBuilder')),
        preferredSize: Size.fromHeight(kAppBarHeight),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          child: Image.asset('assets/images/uzumaki_naruto-011.jpg'),
          builder: (BuildContext context, Widget child) {
            return Container(
              width: MediaQuery.of(context).size.width *
                  _animationController.value,
              height: MediaQuery.of(context).size.width *
                  _animationController.value,
              child: child,
            );
          },
        ),
      ),
    );
  }
}
