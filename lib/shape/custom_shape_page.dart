import 'package:flutter/material.dart';
import 'package:flutter_study/shape/custom_shape/coupon_shape_border.dart';
import 'package:flutter_study/shape/custom_shape/custom_circle_shape.dart';
import 'package:flutter_study/shape/custom_shape/custom_rounded_shape.dart';
import 'package:flutter_study/shape/custom_shape/hole_shape_border.dart';

class CustomShapePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          title: Text('自定义ShapeBorder'),
        ),
        preferredSize: Size.fromHeight(44),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.network(
            'https://cdn.pixabay.com/photo/2020/05/29/08/54/seaside-5234306_1280.jpg',
            fit: BoxFit.cover,
          ),
          _buildBody(context),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final items = [
      _buildCircleShape(),
      _buildRoundedShape(),
      _buildHoleShape(),
      _buildCouponShape(),
      _buildCard(),
      _buildClipPath(),
    ];
    return ListView.separated(
      itemBuilder: (context, index) {
        return items[index];
      },
      separatorBuilder: (context, index) => Divider(
        color: Colors.transparent,
      ),
      itemCount: items.length,
      padding: EdgeInsets.all(18)
          .copyWith(bottom: MediaQuery.of(context).padding.bottom),
    );
  }

  Widget _buildCircleShape() {
    return Material(
      color: Colors.orangeAccent,
      elevation: 3,
      shape: CustomCircleShape(),
      child: Container(
        height: 80,
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        child: Text('CustomCircleShape'),
      ),
    );
  }

  Widget _buildRoundedShape() {
    return Material(
      color: Colors.orangeAccent,
      elevation: 3,
      shape: CustomRoundedShape(),
      child: Container(
        height: 80,
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        child: Text('CustomRoundedShape'),
      ),
    );
  }

  Widget _buildHoleShape() {
    return Material(
      color: Colors.orangeAccent,
      elevation: 3,
      shape: HoleShapeBorder(
        // radius: 25,
        count: 10,
        offset: Offset(0.05, 0.1),
      ),
      child: Container(
        height: 80,
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        child: Text('HoleShapeBorder'),
      ),
    );
  }

  Widget _buildCouponShape() {
    return Material(
      color: Colors.orangeAccent,
      elevation: 3,
      shape: CouponShapeBorder(),
      child: Container(
        height: 160,
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        child: Text('优惠券'),
      ),
    );
  }

  Widget _buildCard() {
    return Card(
      elevation: 3,
      shape: HoleShapeBorder(count: 6),
      child: Container(
        height: 80,
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        child: Text('Card'),
      ),
    );
  }

  Widget _buildClipPath() {
    return Container(
      // width: 300,
      height: 200,
      child: ClipPath(
        clipper: ShapeBorderClipper(
          shape: CouponShapeBorder(),
        ),
        child: Image.network(
          'https://cdn.pixabay.com/photo/2020/06/29/10/08/ballet-5352231_1280.jpg',
          // 'https://cdn.pixabay.com/photo/2020/06/30/22/34/dog-5357794__480.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
