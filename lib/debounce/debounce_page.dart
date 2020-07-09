import 'package:flutter/material.dart';
import 'package:flutter_study/debounce/debounce.dart';

class DebouncePage extends StatefulWidget {
  @override
  _DebouncePageState createState() => _DebouncePageState();
}

class _DebouncePageState extends State<DebouncePage> {
  int _count = 0;
  int _count2 = 0;

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
            '$_count2',
            style: Theme.of(context).textTheme.display1,
          ),
          Center(
            child: RaisedButton.icon(
              icon: Icon(Icons.add),
              label: Text('不防抖'),
              onPressed: () {
                setState(() {
                  _count2++;
                });
              },
            ),
          ),
          Divider(
            height: 8,
          ),
          Text(
            '$_count',
            style: Theme.of(context).textTheme.display1,
          ),
          Center(
            child: RaisedButton.icon(
              icon: Icon(Icons.add),
              label: Text('防抖'),
              onPressed: debounce(() {
                if (!mounted) {
                  return;
                }
                setState(() {
                  _count++;
                });
              }),
            ),
          ),
        ],
      ),
    );
  }
}
