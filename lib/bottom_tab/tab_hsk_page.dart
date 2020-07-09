import 'package:flutter/material.dart';

class TabHSKPage extends StatefulWidget {
  @override
  _TabHSKPageState createState() => _TabHSKPageState();
}

class _TabHSKPageState extends State<TabHSKPage>
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
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Card(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.access_time, size: 128.0, color: textStyle.color),
              Text(this.widget.runtimeType.toString(), style: textStyle),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
