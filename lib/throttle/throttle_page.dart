import 'package:flutter/material.dart';
import 'package:flutter_study/throttle/throttle.dart';

class ThrottlePage extends StatefulWidget {
  @override
  _ThrottlePageState createState() => _ThrottlePageState();
}

class _ThrottlePageState extends State<ThrottlePage> {
  int _count = 0;
  int _count2 = 0;
  int _count3 = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(),
        preferredSize: Size.fromHeight(44),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '$_count',
            style: Theme.of(context).textTheme.display1,
          ),
          Center(
            child: RaisedButton.icon(
              icon: Icon(Icons.add),
              label: Text('节流，耗时操作2s'),
              onPressed: throttle(() async {
                await Future.delayed(Duration(milliseconds: 2000));
                if (!mounted) {
                  return;
                }
                setState(() {
                  _count++;
                });
              }),
            ),
          ),
          Divider(
            height: 8,
          ),
          Text(
            '$_count3',
            style: Theme.of(context).textTheme.display1,
          ),
          Center(
            child: RaisedButton.icon(
              icon: Icon(Icons.add),
              label: Text('不节流，耗时操作2s'),
              onPressed: () async {
                await Future.delayed(Duration(milliseconds: 2000));
                if (!mounted) {
                  return;
                }
                setState(() {
                  _count3++;
                });
              },
            ),
          ),
          Divider(
            height: 8,
          ),
          Text(
            '$_count2',
            style: Theme.of(context).textTheme.display1,
          ),
          Center(
            child: RaisedButton.icon(
              icon: Icon(Icons.add),
              label: Text('不节流，不耗时'),
              onPressed: throttle(() async {
                // await Future.delayed(Duration(milliseconds: 4000));
                if (!mounted) {
                  return;
                }
                setState(() {
                  _count2++;
                });
              }),
            ),
          ),
        ],
      ),
    );
  }
}
