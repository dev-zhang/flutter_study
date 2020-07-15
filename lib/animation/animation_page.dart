import 'package:flutter/material.dart';
import 'package:flutter_study/animation/animated_builder_page.dart';
import 'package:flutter_study/animation/animated_switcher_page.dart';
import 'package:flutter_study/animation/animated_widget_page.dart';
import 'package:flutter_study/animation/animationcontroller_page.dart';
import 'package:flutter_study/animation/hero_page.dart';
import 'package:flutter_study/animation/route_animation_page.dart';
import 'package:flutter_study/animation/stagger_animation_page.dart';
import 'package:flutter_study/constant/constant.dart';

class AnimationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(title: Text('Flutter animation')),
        preferredSize: Size.fromHeight(kAppBarHeight),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
            top: 20, bottom: MediaQuery.of(context).padding.bottom),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildItem(
              context,
              title: 'Animation<T>',
              targetPage: AnimationControllerPage(),
            ),
            _buildItem(
              context,
              title: 'AnimatedWidget',
              targetPage: AnimatedWidgetPage(),
            ),
            _buildItem(
              context,
              title: 'AnimatedBuilder',
              targetPage: AnimatedBuilderPage(),
            ),
            _buildItem(
              context,
              title: '路由动画',
              targetPage: RouteAnimationPage(),
            ),
            _buildItem(
              context,
              title: 'Hero',
              targetPage: HeroPage(),
            ),
            _buildItem(
              context,
              title: '交织动画',
              targetPage: StaggerAnimationPage(),
            ),
            _buildItem(
              context,
              title: 'AnimatedSwitcher',
              targetPage: AnimatedSwitcherPage(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(
    BuildContext context, {
    @required String title,
    @required Widget targetPage,
  }) {
    return Container(
      width: 300,
      height: 60,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => targetPage),
          );
        },
        child: Card(
          child: Center(
            child: Text(
              title,
              style: Theme.of(context).textTheme.title,
            ),
          ),
        ),
      ),
    );
  }
}
