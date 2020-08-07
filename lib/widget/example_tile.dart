import 'package:flutter/material.dart';

class ExampleTile extends StatelessWidget {
  const ExampleTile({
    Key key,
    this.onTap,
    this.targetPage,
    @required this.title,
  })  : assert(title != null),
        assert(onTap != null || targetPage != null),
        super(key: key);

  final VoidCallback onTap;
  final Widget targetPage;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 60,
      child: InkWell(
        onTap: onTap ??
            () {
              if (targetPage == null) {
                return;
              }
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => targetPage),
              );
            },
        child: Card(
          child: Center(
            child: Text(
              title,
              style: Theme.of(context).textTheme.button,
            ),
          ),
        ),
      ),
    );
  }
}
