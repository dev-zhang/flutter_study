import 'package:flutter/material.dart';
import 'package:flutter_study/bottom_tab/global_event_bus.dart';

class TabStudyPage extends StatefulWidget {
  @override
  _TabStudyPageState createState() => _TabStudyPageState();
}

class _TabStudyPageState extends State<TabStudyPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    print('====init state==${this.runtimeType}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.accessibility_new,
                    size: 128.0, color: textStyle.color),
                Text(this.widget.runtimeType.toString(), style: textStyle),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GlobalEventBus.eventBus.fire(SendEvent());
        },
        child: Icon(Icons.send),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
