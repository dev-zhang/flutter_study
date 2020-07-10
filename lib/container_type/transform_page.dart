import 'dart:math';

import 'package:flutter/material.dart';

class TransformPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('变换')),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            _buildSkew(),
            _buildTranslate(),
            _buildRotate(),
            _buildScale(),
            _buildRotatedBox(),
          ],
        ),
      ),
    );
  }

  Widget _buildSkew() {
    return Container(
      color: Colors.black87,
      margin: EdgeInsets.all(60),
      child: Transform(
        alignment: Alignment.topRight,
        transform: Matrix4.skewY(17 * pi / 180),
        child: Container(
          color: Colors.blueAccent,
          padding: EdgeInsets.all(8),
          child: Text(
            'Apartment for rent！',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildTranslate() {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.orangeAccent,
      ),
      child: Transform.translate(
        offset: Offset(-20, -15),
        child: Text(
          'Transform.translate',
          style: TextStyle(fontSize: 28),
        ),
      ),
    );
  }

  Widget _buildRotate() {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: DecoratedBox(
        decoration: BoxDecoration(color: Colors.orangeAccent),
        child: Transform.rotate(
          angle: pi / 12,
          child: Text('Transform.rotate', style: TextStyle(fontSize: 28)),
        ),
      ),
    );
  }

  Widget _buildScale() {
    return Padding(
      padding: EdgeInsets.all(30),
      child: DecoratedBox(
        decoration: BoxDecoration(color: Colors.orangeAccent),
        child: Transform.scale(
          scale: 2.0,
          child: Text('Transform.scale', style: TextStyle(fontSize: 20)),
        ),
      ),
    );
  }

  Widget _buildRotatedBox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        DecoratedBox(
          decoration: BoxDecoration(color: Colors.orangeAccent),
          child: RotatedBox(
            quarterTurns: 1,
            child: Text(
              'RotatedBox',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
        Text('Flutter', style: TextStyle(fontSize: 20)),
      ],
    );
  }
}
