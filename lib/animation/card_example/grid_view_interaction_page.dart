import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_study/animation/card_example/detail_page.dart';
import 'package:flutter_study/animation/card_example/provider/animation_provider.dart';
import 'package:flutter_study/constant/constant.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class GridViewInteractionPage extends StatefulWidget {
  @override
  _GridViewInteractionPageState createState() =>
      _GridViewInteractionPageState();
}

class _GridViewInteractionPageState extends State<GridViewInteractionPage> {
  List<CardModel> _datas = <CardModel>[];

  @override
  void initState() {
    _mockData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(title: Text('点击交互动画实例')),
        preferredSize: Size.fromHeight(kAppBarHeight),
      ),
      body: ChangeNotifierProvider(
        create: (_) => AnimationProvider(),
        child: Builder(builder: (BuildContext context) {
          return _buildBody(context);
        }),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      top: false,
      child: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SizedBox(height: 10),
            Text(
              '多吃水果，有益健康',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            Icon(
              Icons.audiotrack,
              size: 45,
              color: Colors.orange,
            ),
            Spacer(),
            Consumer<AnimationProvider>(
              builder: (BuildContext context, AnimationProvider provider,
                  Widget child) {
                return ConstrainedBox(
                  constraints: BoxConstraints.tight(Size(154, 49.5 + 6)),
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Positioned(
                        top: 6,
                        child: SlideTransition(
                          position: provider.answerEvaluationOffset,
                          child: FadeTransition(
                            opacity: provider.answerEvaluationOpacity,
                            child: ScaleTransition(
                              scale: provider.answerEvaluationScale,
                              child: SvgPicture.asset(
                                'assets/svgs/perfect.svg',
                                width: 154,
                                height: 49.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 5.5,
                        top: 0,
                        child: SlideTransition(
                          position: provider.shineOffset,
                          child: FadeTransition(
                            opacity: provider.shineOpacity,
                            // opacity: ConstantTween(1.0)
                            //     .animate(provider.animationController),
                            child: ScaleTransition(
                              scale: provider.shineScale,
                              child: SvgPicture.asset(
                                'assets/svgs/shine.svg',
                                width: 10.5,
                                height: 11,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            // SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                itemCount: _datas.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 25),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 13,
                  mainAxisSpacing: 17,
                  childAspectRatio: 156.0 / 104.0,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return ImageCard(
                    model: _datas[index],
                    index: index,
                    onTap: () {
                      // _nextQuestion();
                      // _showDetailPage(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _nextQuestion() async {
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      _mockData();
    });
  }

  Future<void> _showDetailPage(BuildContext context) async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => DetailPage(),
      ),
    );
  }

  void _mockData() async {
    final imgSrcs =
        List.generate(8, (int i) => 'assets/images/img_0${i + 1}.jpg');

    if (_datas.isEmpty) {
      _datas = imgSrcs
          .skip(4)
          .map<CardModel>(
              (String imgSrc) => CardModel(imgSrc: imgSrc, isAnswer: false))
          .toList();
      _datas[Random().nextInt(3)].isAnswer = true;
    } else {
      _datas = imgSrcs
          .where((value) => _datas.every((item) => item.imgSrc != value))
          .map((String imgSrc) {
        return CardModel(
          imgSrc: imgSrc,
          isAnswer: false,
        );
      }).toList();
      _datas[Random().nextInt(3)].isAnswer = true;
    }
  }
}

class CardModel {
  CardModel({
    this.imgSrc,
    this.isAnswer,
  });

  String imgSrc;
  bool isAnswer;
}

class ImageCard extends StatefulWidget {
  const ImageCard({
    Key key,
    @required this.model,
    this.onTap,
    @required this.index,
  })  : assert(model != null),
        assert(index != null),
        super(key: key);

  final CardModel model;
  final int index;
  final Function onTap;

  @override
  _ImageCardState createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _scaleAnimation;
  // 遮罩颜色动画
  Animation<double> _maskOpacityAnimation;

  bool _isTapDown = false;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );

    _scaleAnimation = Tween<double>(begin: 1, end: 0.94).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
        reverseCurve: Curves.easeOut,
      ),
    );
    _maskOpacityAnimation = Tween<double>(begin: 0, end: 0.6).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
        reverseCurve: Curves.easeOut,
      ),
    );

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AnimationProvider>(
      builder:
          (BuildContext context, AnimationProvider provider, Widget child) {
        return ScaleTransition(
          // scale: _scaleAnimation,
          scale: provider.scaleAnimation(widget.index),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: InkWell(
              child: DecoratedBoxTransition(
                decoration: provider.decorationAnimation(widget.index),
                position: DecorationPosition.foreground,
                // child: Image.asset(widget.model.imgSrc),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Image.asset(widget.model.imgSrc),
                    Builder(
                      builder: (_) {
                        final image = SvgPicture.asset(
                          'assets/svgs/answer_correct.svg',
                          width: 100,
                          height: 100,
                        );
                        if (provider.isSelected(widget.index)) {
                          return FadeTransition(
                            opacity: provider.answerResultOpacity,
                            child: ScaleTransition(
                              scale: provider.answerResultScale,
                              child: image,
                            ),
                          );
                        }
                        return Container();
                      },
                    ),
                  ],
                ),
              ),
              onTap: () {
                provider.onTapItem(widget.index);
                // _updateReverseAnimation();
                if (widget.onTap != null) {
                  widget.onTap();
                }
              },
              onTapDown: (TapDownDetails details) {
                // _updateForwardAnimation();
                provider.onTapDownItem(widget.index);
              },
              onTapCancel: () {
                print('======on tap cancel===');
              },
            ),
          ),
        );
      },
    );
  }

  void _updateForwardAnimation() {
    _isTapDown = true;
    // _scaleAnimation = Tween<double>(begin: 1, end: 0.94).animate(
    //   CurvedAnimation(
    //     parent: _animationController,
    //     curve: Curves.easeIn,
    //     reverseCurve: Curves.easeOut,
    //   ),
    // );
    // _maskOpacityAnimation = Tween<double>(begin: 0, end: 0.6).animate(
    //   CurvedAnimation(
    //     parent: _animationController,
    //     curve: Curves.easeIn,
    //     reverseCurve: Curves.easeOut,
    //   ),
    // );
    _animationController.forward(from: 0);
    // setState(() {});
  }

  void _updateReverseAnimation() {
    _isTapDown = false;
    try {
      _animationController.removeStatusListener(_forwardListener);
    } catch (e) {}
    if (_animationController.status == AnimationStatus.completed) {
      // _scaleAnimation = Tween<double>(begin: 1, end: 0.94).animate(
      //   CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
      // );
      // _maskOpacityAnimation = Tween<double>(begin: 0, end: 0.6).animate(
      //   CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
      // );
      // setState(() {});
      _animationController.reverse(from: 1);
    } else if (_animationController.status == AnimationStatus.forward) {
      _animationController.addStatusListener(_forwardListener);
    }
  }

  void _forwardListener(AnimationStatus status) {
    if (status == AnimationStatus.completed && !_isTapDown) {
      // _scaleAnimation = Tween<double>(begin: 1, end: 0.94).animate(
      //   CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
      // );
      // _maskOpacityAnimation = Tween<double>(begin: 0, end: 0.6).animate(
      //   CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
      // );

      // setState(() {});
      _animationController.reverse(from: 1);
    } else if (status == AnimationStatus.dismissed) {
      try {
        _animationController.removeStatusListener(_forwardListener);
      } catch (e) {}
    }
  }
}
