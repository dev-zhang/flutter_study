import 'package:flutter/material.dart';
import 'package:flutter_study/constant/constant.dart';

class EdgeInsetsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(title: Text('EdgeInset geometry')),
        preferredSize: Size.fromHeight(kAppBarHeight),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Directionality(
            textDirection: TextDirection.ltr,
            child: Column(
              children: <Widget>[
                Container(
                  color: Colors.orangeAccent,
                  height: 50,
                  width: double.infinity,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 30),
                  padding: EdgeInsets.fromLTRB(10, 0, 80, 0),
                  child: Container(
                    color: Colors.yellowAccent,
                    width: double.infinity,
                    child: Text(
                        'TextDirection.ltr==EdgeInsets.fromLTRB(10, 0, 80, 0)'),
                  ),
                ),
                Container(
                  color: Colors.orangeAccent,
                  height: 50,
                  width: double.infinity,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 30),
                  padding: EdgeInsetsDirectional.fromSTEB(10, 0, 80, 0),
                  child: Container(
                    color: Colors.yellowAccent,
                    width: double.infinity,
                    child: Text(
                        'TextDirection.ltr==EdgeInsetsDirectional.fromSTEB(10, 0, 80, 0)'),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          Divider(),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              children: <Widget>[
                Container(
                  color: Colors.orangeAccent,
                  height: 50,
                  width: double.infinity,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 30),
                  // EdgeInsets: 使用物理标签
                  padding: EdgeInsets.fromLTRB(10, 0, 80, 0),
                  child: Container(
                    color: Colors.yellowAccent,
                    width: double.infinity,
                    child: Text(
                        'TextDirection.rtl==EdgeInsets.fromLTRB(10, 0, 80, 0)'),
                  ),
                ),
                Container(
                  color: Colors.orangeAccent,
                  height: 50,
                  width: double.infinity,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 30),
                  // 取决于文字的书写方向
                  padding: EdgeInsetsDirectional.fromSTEB(10, 0, 80, 0),
                  child: Container(
                    color: Colors.yellowAccent,
                    width: double.infinity,
                    child: Text(
                        'TextDirection.rtl==EdgeInsetsDirectional.fromSTEB(10, 0, 80, 0)'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
