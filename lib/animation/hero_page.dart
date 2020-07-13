import 'package:flutter/material.dart';
import 'package:flutter_study/constant/constant.dart';

class HeroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(title: Text('Hero动画')),
        preferredSize: Size.fromHeight(kAppBarHeight),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Center(
      child: InkWell(
        child: ClipOval(
          child: SizedBox.fromSize(
            size: Size.fromRadius(50),
            child: Hero(
              // Hero动画的标识，前后两个路由页面Hero的tag必须一致，
              tag: 'Avatar',
              child: Image.asset(
                'assets/images/uzumaki_naruto-011.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) {
              return Scaffold(
                appBar: PreferredSize(
                  child: AppBar(title: Text('User')),
                  preferredSize: Size.fromHeight(kAppBarHeight),
                ),
                body: Container(
                  margin: EdgeInsets.all(20),
                  child: Hero(
                    // Hero动画的标识，前后两个路由页面Hero的tag必须一致，
                    tag: 'Avatar',
                    child: Image.asset(
                      'assets/images/uzumaki_naruto-011.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
