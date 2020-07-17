import 'package:flutter/material.dart';
import 'package:flutter_study/constant/constant.dart';

class RouteAnimationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          title: Text('路由动画'),
        ),
        preferredSize: Size.fromHeight(kAppBarHeight),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            _buildItem(context, title: 'MaterialPageRoute', onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => EmptyPage()),
              );
            }),
            _buildItem(
              context,
              title: 'PageRouteBuilder',
              onTap: () {
                Navigator.of(context).push(PageRouteBuilder(pageBuilder:
                    (BuildContext context, Animation<double> animation,
                        Animation<double> secondaryAnimation) {
                  return FadeTransition(
                    opacity: animation,
                    child: EmptyPage(),
                  );
                }));
              },
            ),
            _buildItem(context, title: 'PageRoute', onTap: () {
              Navigator.of(context).push(
                FadeRoute(builder: (_) => EmptyPage()),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(
    BuildContext context, {
    @required String title,
    Function onTap,
  }) {
    return Container(
      margin: EdgeInsets.all(10),
      width: 300,
      height: 100,
      child: InkWell(
        onTap: onTap,
        child: Card(
          child: Center(
            child: Text(
              title,
              style: Theme.of(context).textTheme.button,
            ),
          ),
        ),
      ),
    );
  }
}

class FadeRoute extends PageRoute {
  final WidgetBuilder builder;
  final Duration _transitionDuration;

  FadeRoute({
    @required this.builder,
    Duration transitionDuration = const Duration(milliseconds: 300),
  }) : _transitionDuration = transitionDuration;

  @override
  Color get barrierColor => null;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return builder(context);
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: buildPage(context, animation, secondaryAnimation),
    );
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => _transitionDuration;
}

class EmptyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          title: Text('EmptyPage'),
        ),
        preferredSize: Size.fromHeight(kAppBarHeight),
      ),
      body: Center(
        child: Text(
          '啥都没有……',
          style: Theme.of(context).textTheme.display1,
        ),
      ),
    );
  }
}
