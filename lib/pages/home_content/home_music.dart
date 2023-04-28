import 'dart:io';
import 'package:flutter/material.dart';

class StarkMusic extends StatefulWidget {
  const StarkMusic({Key? key}) : super(key: key);
  @override
  _userPageContent createState() => _userPageContent();
}

class _userPageContent extends State<StarkMusic>
    with SingleTickerProviderStateMixin {
  @override
  late final AnimationController _playerController;
  late final Animation _animation;

  @override
  void initState() {
    super.initState();
    _playerController = AnimationController(
        duration: const Duration(seconds: 300), vsync: this);
    _animation = Tween<double>(begin: 1, end: 300).animate(_playerController);
    // ..addStatusListener((status) {
    //   _playerController.forward();
    // });
  }

  @override
  Widget userMusic = Container(
    width: 120,
    height: 120,
    alignment: Alignment.topCenter,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: NetworkImage(
            'https://p3.music.126.net/sixunTcvD_IXeVqxZnpHkA==/109951163452086313.jpg'),
        fit: BoxFit.cover,
      ),
      shape: BoxShape.rectangle,
      borderRadius: new BorderRadius.all(
        const Radius.circular(7.0), // 设置图片为圆形
      ),
    ),
    child: Stack(
      children: [
        Positioned(
          top: 20,
          child: RotationTransition(
              alignment: Alignment.center,
              turns: _animation,
              child: Container(
                  decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'https://p3.music.126.net/sixunTcvD_IXeVqxZnpHkA==/109951163452086313.jpg'),
                  fit: BoxFit.cover,
                ),
              ))),
        )
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 510,
      height: 175,
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(10),
      decoration: new BoxDecoration(
          borderRadius: new BorderRadius.all(const Radius.circular(11.0)),
          color: Color.fromARGB(202, 255, 255, 255)),
      child: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [userMusic],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
          )
        ],
      ),
    );
  }
}
