import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class VectorgraphPage extends StatefulWidget {
  _VectorgraphPageState createState() => _VectorgraphPageState();
}

class _VectorgraphPageState extends State<VectorgraphPage> {
  double _width = 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(title: Text('矢量图')),
        preferredSize: Size.fromHeight(44),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Slider(
              value: _width,
              min: 100,
              max: MediaQuery.of(context).size.width,
              onChanged: (value) {
                setState(() {
                  _width = value;
                });
              },
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    width: _width,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: SvgPicture.network(
                        'https://www.svgrepo.com/show/3682/dog-food.svg',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  AnimatedContainer(
                    duration: Duration(microseconds: 200),
                    width: _width,
                    margin: EdgeInsets.only(top: 20),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: SvgPicture.asset(
                        'assets/images/img_add_pic.svg',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  AnimatedContainer(
                    duration: Duration(microseconds: 200),
                    width: _width,
                    margin: EdgeInsets.only(top: 20),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: SvgPicture.asset(
                        'assets/images/img_grade_a.svg',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  AnimatedContainer(
                    duration: Duration(microseconds: 200),
                    width: _width,
                    margin: EdgeInsets.only(top: 20),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: SvgPicture.asset(
                        'assets/images/img_play.svg',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
