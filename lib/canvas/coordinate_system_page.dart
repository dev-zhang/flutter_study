import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'widget/coordinate_system_widget.dart';

class CoordinateSystemPage extends StatefulWidget {
  _CoordinateSystemPageState createState() => _CoordinateSystemPageState();
}

class _CoordinateSystemPageState extends State<CoordinateSystemPage> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);

    super.initState();
  }

  @override
  void deactivate() {
    super.deactivate();

    if (ModalRoute.of(context).isCurrent) {
      SystemChrome.setEnabledSystemUIOverlays([]);
    } else {
      SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.fromSize(
        size: MediaQuery.of(context).size,
        child: CoordinateSystemWidget(),
      ),
    );
  }
}
