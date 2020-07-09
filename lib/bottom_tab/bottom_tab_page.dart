import 'package:flutter/material.dart';
import 'package:flutter_study/bottom_tab/tab_home_page.dart';
import 'package:flutter_study/bottom_tab/tab_hsk_page.dart';
import 'package:flutter_study/bottom_tab/tab_study_page.dart';

class BottomTabPage extends StatefulWidget {
  @override
  _BottomTabPageState createState() => _BottomTabPageState();
}

class _BottomTabPageState extends State<BottomTabPage> {
  List<BottomNavigationBarItem> _items;
  List<Widget> _pages;
  int _currentIndex = 0;

  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();

    _items = [
      BottomNavigationBarItem(
        icon: Icon(Icons.access_alarm),
        title: Container(),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.access_time),
        title: Container(),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.accessibility_new),
        title: Container(),
      ),
    ];

    _pages = [
      TabHomePage(),
      TabHSKPage(),
      TabStudyPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          title: Text('navigation bar'),
        ),
        preferredSize: Size.fromHeight(44),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.orange,
        items: _items,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          // setState(() {
          //   _currentIndex = index;
          // });

          // page view的方式
          setState(() {
            _currentIndex = index;
          });
          _pageController.jumpToPage(_currentIndex);
        },
      ),
      // body: _buildSingle(context),
      // body: _buildStack(context),
      // body: _buildIndexedStack(context),
      body: _buildPageView(context),
    );
  }

  // 这种方式不会一次加载全部的page
  // 哪个被选中加载哪一个page，
  // 已经加载过的page会被释放，下次选中的时候会再次加载，丢失之前的页面状态
  Widget _buildSingle(BuildContext context) {
    return _pages[_currentIndex];
  }

  // 这种方式会一次加载全部的page
  Widget _buildStack(BuildContext context) {
    return Stack(
      children: _pages
          .map<Widget>(
            (Widget page) => Offstage(
              offstage: _currentIndex != _pages.indexOf(page),
              child: page,
            ),
          )
          .toList(),
    );
  }

  // 这种方式会一次加载全部的page，与Stack基本一致
  Widget _buildIndexedStack(BuildContext context) {
    return IndexedStack(
      index: _currentIndex,
      children: _pages,
    );
  }

  // 不会一次加载全部的page，再配合page混入AutomaticKeepAliveClientMixin，重写wantKeepAlive方法放回true，
  // 即可实现page的状态保持
  Widget _buildPageView(BuildContext context) {
    return PageView(
      children: _pages,
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
    );
  }
}
