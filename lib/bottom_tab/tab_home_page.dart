import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_study/bottom_tab/global_event_bus.dart';

class TabHomePage extends StatefulWidget {
  @override
  _TabHomePageState createState() => _TabHomePageState();
}

class _TabHomePageState extends State<TabHomePage>
    with AutomaticKeepAliveClientMixin {
  int _count = 0;
  StreamSubscription _streamSubscription;

  @override
  void initState() {
    print('====init state==${this.runtimeType}');
    super.initState();

    _streamSubscription =
        GlobalEventBus.eventBus.on<SendEvent>().listen((SendEvent send) {
      setState(() {
        _count++;
      });
    });
  }

  @override
  void dispose() {
    print('=====dispose==${this.runtimeType}');
    // 由于GlobalEventBus.eventBus的生命周期长于当前页面，因此在当前页面销毁时需要取消订阅
    _streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Card(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.access_alarm, size: 128.0, color: textStyle.color),
              Text(this.widget.runtimeType.toString(), style: textStyle),
              Text(
                '$_count',
                style: textStyle.copyWith(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
