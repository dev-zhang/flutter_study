import 'package:flutter/material.dart';
import 'package:flutter_study/shape/custom_shape_page.dart';
import 'package:flutter_study/shape/flutter_build_in_shape_page.dart';

// 来源 https://juejin.im/post/5e6196066fb9a07c8b5bbdf5

class ShapePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          title: Text('Shape'),
        ),
        preferredSize: Size.fromHeight(44),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: DefaultTextStyle(
        style: TextStyle(color: Colors.white, fontSize: 20),
        child: Column(
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => FlutterBuildInShapePage()),
                );
              },
              child: Container(
                color: Colors.orangeAccent,
                alignment: Alignment.center,
                margin: EdgeInsets.all(10),
                height: 80,
                child: Text('Flutter 内置的Shape'),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => CustomShapePage()),
                );
              },
              child: Container(
                margin: EdgeInsets.all(10),
                color: Colors.orangeAccent,
                alignment: Alignment.center,
                height: 80,
                child: Text('自定义Shape'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
