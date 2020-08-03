import 'package:flutter/material.dart';
import 'package:flutter_study/constant/constant.dart';

class AnonymousFunctionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _test();
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(title: Text('匿名函数')),
        preferredSize: Size.fromHeight(kAppBarHeight),
      ),
    );
  }

  void _test() {
    final List<int> numbers = [1, 2, 3, 4, 5];
    // numbers.forEach(print);

    // 以下几种写法的输出结果一致
    numbers.forEach((i) => print(i * i));

    numbers.forEach((i) => print((i) {
          return i * i;
        }(i)));

    numbers.forEach((i) => print((j) {
          return j * j;
        }(i)));

    numbers.forEach((i) => print(((j) => j * j)(i)));
  }
}
