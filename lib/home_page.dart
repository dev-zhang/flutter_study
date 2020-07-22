import 'package:flutter/material.dart';
import 'package:flutter_study/animation/animation_page.dart';
import 'package:flutter_study/bottom_tab/bottom_tab_page.dart';
import 'package:flutter_study/bottom_tab/global_event_bus.dart';
import 'package:flutter_study/color_recognition/color_recognition_page.dart';
import 'package:flutter_study/container_type/container_type_list_page.dart';
import 'package:flutter_study/debounce/debounce_page.dart';
import 'package:flutter_study/shape/shape_page.dart';
import 'package:flutter_study/throttle/throttle_page.dart';
import 'package:flutter_study/ui_adaptation/ui_adaptation_page.dart';
import 'package:flutter_study/vectorgraph/vectorgraph_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          title: Text('flutter study'),
        ),
        preferredSize: Size.fromHeight(44),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildItem(context, title: '识别图片颜色', onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => ColorRecognitionPage()),
              );
            }),
            _buildItem(context, title: '底部导航+状态保持', onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => BottomTabPage()),
              );
            }),
            Builder(builder: (context) {
              return _buildItem(context, title: 'event bus，发布事件', onTap: () {
                GlobalEventBus.eventBus.fire(SendEvent());
                if (!GlobalEventBus.eventBus.streamController.hasListener) {
                  Scaffold.of(context).removeCurrentSnackBar(
                      reason: SnackBarClosedReason.remove);
                  Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text('暂无订阅者')),
                  );
                }
              });
            }),
            _buildItem(context, title: '防抖', onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => DebouncePage()),
              );
            }),
            _buildItem(context, title: '节流', onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => ThrottlePage()),
              );
            }),
            _buildItem(context, title: 'Shape', onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => ShapePage()),
              );
            }),
            _buildItem(context, title: '矢量图', targetPage: VectorgraphPage()),
            _buildItem(context,
                title: '容器类组件', targetPage: ContainerTypeListPage()),
            _buildItem(context, title: 'UI适配', targetPage: UIAdaptationPage()),
            _buildItem(context, title: '动画', targetPage: AnimationPage()),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(
    BuildContext context, {
    @required String title,
    void Function() onTap,
    Widget targetPage,
  }) {
    return Container(
      width: 300,
      height: 60,
      child: InkWell(
        onTap: onTap ??
            () {
              if (targetPage == null) {
                return;
              }
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => targetPage),
              );
            },
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
