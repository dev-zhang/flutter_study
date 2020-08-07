import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BezierPathPage extends StatefulWidget {
  @override
  _BezierPathPageState createState() => _BezierPathPageState();
}

class _BezierPathPageState extends State<BezierPathPage> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  @override
  void deactivate() {
    if (ModalRoute.of(context).isCurrent) {
      SystemChrome.setEnabledSystemUIOverlays([]);
    } else {
      SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    }
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
