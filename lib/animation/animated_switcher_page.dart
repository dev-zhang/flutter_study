import 'package:flutter/material.dart';
import 'package:flutter_study/constant/constant.dart';
import 'package:flutter_svg/svg.dart';

class AnimatedSwitcherPage extends StatefulWidget {
  @override
  _AnimatedSwitcherPageState createState() => _AnimatedSwitcherPageState();
}

class _AnimatedSwitcherPageState extends State<AnimatedSwitcherPage> {
  int _count = 0;
  // 是否已收藏
  bool _isFavorited = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(title: Text('AnimatedSwitcher')),
        preferredSize: Size.fromHeight(kAppBarHeight),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          IconButton(
            iconSize: 80,
            icon: Icon(
              Icons.add,
              color: Colors.orangeAccent,
            ),
            onPressed: () {
              setState(() {
                _count++;
              });
            },
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.blue[200],
            ),
            child: Container(
              width: 200,
              height: 200,
              alignment: Alignment.center,
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 600),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(
                    scale: animation,
                    child: child,
                  );
                },
                child: Text(
                  '$_count',
                  key: ValueKey(_count),
                  style: Theme.of(context).textTheme.display4,
                ),
              ),
            ),
          ),
          _buildFavoriteButton(context),
        ],
      ),
    );
  }

  Widget _buildFavoriteButton(BuildContext context) {
    String src = 'assets/images/favorite_normal.svg';
    if (_isFavorited) {
      src = 'assets/images/favorite_selected.svg';
    }
    return Container(
      margin: EdgeInsets.all(20),
      child: FlatButton.icon(
        onPressed: () {
          setState(() {
            _isFavorited = !_isFavorited;
          });
        },
        icon: AnimatedSwitcher(
          duration: Duration(milliseconds: 600),
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.easeOut,
          reverseDuration: Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            final scale =
                Tween<double>(begin: 0.1, end: 1.0).animate(animation);
            return ScaleTransition(
              scale: scale,
              child: child,
            );
          },
          child: SvgPicture.asset(
            src,
            key: ValueKey(src),
          ),
        ),
        label: Container(
          color: Colors.orange,
        ),
      ),
    );
  }
}
