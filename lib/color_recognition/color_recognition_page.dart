import 'package:color_thief_flutter/color_thief_flutter.dart';
import 'package:flutter/material.dart';

class ColorRecognitionPage extends StatefulWidget {
  @override
  _ColorRecognitionPageState createState() => _ColorRecognitionPageState();
}

class _ColorRecognitionPageState extends State<ColorRecognitionPage> {
  var _result;
  String _currentImageSrc;

  List<String> _imageSrcs = [
    'https://github.githubassets.com/images/modules/open_graph/github-octocat.png',
    'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1593336295038&di=2b6f17281dc48fc3dc056b945947331c&imgtype=0&src=http%3A%2F%2Fa2.att.hudong.com%2F36%2F48%2F19300001357258133412489354717.jpg',
    'https://upload-images.jianshu.io/upload_images/5547112-99b5c04073a1b0df.png?imageMogr2/auto-orient/strip|imageView2/2/w/896/format/webp',
    'https://upload-images.jianshu.io/upload_images/5547112-c372f8976232d30d.png?imageMogr2/auto-orient/strip|imageView2/2/w/896/format/webp',
    'https://cdn.jsdelivr.net/gh/dev-zhang/imgHosting/img/image-20200609154835043.png'
  ];

  int _currentIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          title: Text('识别图片的颜色'),
        ),
        preferredSize: Size.fromHeight(44),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          RaisedButton.icon(
            onPressed: () {
              _onTap(context);
            },
            icon: Icon(Icons.touch_app),
            label: Text(''),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _currentImageSrc != null
                  ? Image.network(_currentImageSrc)
                  : SizedBox(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${_result ?? ''}',
                ),
              ),
              _result != null
                  ? Padding(
                      padding: EdgeInsets.all(20),
                      child: Container(
                        width: 300,
                        height: 80,
                        color: Color.fromARGB(
                            255, _result[0], _result[1], _result[2]),
                      ),
                    )
                  : Container(),
            ],
          ),
        ],
      ),
    );
  }

  void _onTap(BuildContext context) {
    if (_currentIndex == null) {
      _currentIndex = 0;
    } else if (_currentIndex >= _imageSrcs.length ||
        (_currentIndex + 1) >= _imageSrcs.length) {
      _currentIndex = 0;
    } else {
      _currentIndex++;
    }
    setState(() {
      _currentImageSrc = _imageSrcs[_currentIndex];
    });

    getColorFromUrl(_currentImageSrc).then((color) {
      // [R, G, B]
      print('=======get color from url: $color');
      setState(() {
        _result = color;
      });
    });
  }
}
