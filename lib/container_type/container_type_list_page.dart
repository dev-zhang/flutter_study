import 'package:flutter/material.dart';
import 'package:flutter_study/container_type/clip_page.dart';
import 'package:flutter_study/container_type/transform_page.dart';

class ContainerTypeListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          title: Text('容器类组件'),
        ),
        preferredSize: Size.fromHeight(44),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    final items = <Widget>[
      _buildItem(context, title: 'Transform', targetPage: TransformPage()),
      _buildItem(context, title: '裁剪', targetPage: ClipPage()),
    ];
    return ListView.separated(
      itemBuilder: (context, index) => items[index],
      separatorBuilder: (context, index) => Divider(
        color: Colors.transparent,
      ),
      itemCount: items.length,
      padding: EdgeInsets.all(18),
    );
  }

  Widget _buildItem(
    BuildContext context, {
    @required String title,
    @required Widget targetPage,
  }) {
    return Center(
      child: Container(
        width: 300,
        height: 90,
        child: InkWell(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => targetPage));
          },
          child: Card(
            color: Theme.of(context).cardColor,
            child: Center(
              child: Text(
                title,
                style: Theme.of(context).textTheme.title,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
