import 'dart:io';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/status.dart';

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
    _playerController =
        AnimationController(duration: const Duration(seconds: 3), vsync: this)
          ..repeat();
    _animation = Tween<double>(begin: 1, end: 3).animate(_playerController)
      ..addStatusListener((status) {
        _playerController.forward();
      });
    super.initState();
  }

  @override
  Widget userMusic = Container();

  @override
  Widget userMusicText = Container(
    width: 100,
    child: Text('As I Moved On',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        )),
  );

  @override
  Widget userAuthor = Container(
    width: 90,
    padding: const EdgeInsets.only(top: 10),
    child: Text('Sweep Of Days',
        style: TextStyle(
            fontSize: 12, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 450,
      height: 140,
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(10),
      decoration: new BoxDecoration(
          borderRadius: new BorderRadius.all(const Radius.circular(11.0)),
          color: Color.fromARGB(202, 255, 255, 255)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 120,
                height: 120,
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://p3.music.126.net/HaZXKgb5D_0Q_7FoxfCL-A==/109951167995289964.jpg?param=200y200'),
                    fit: BoxFit.cover,
                  ),
                  shape: BoxShape.rectangle,
                  borderRadius: new BorderRadius.all(
                    const Radius.circular(7.0), // 设置图片为圆形
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                width: 70,
                height: 120,
                alignment: Alignment.topCenter,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: -60,
                      child: RotationTransition(
                          alignment: Alignment.center,
                          turns: _playerController,
                          child: Container(
                            decoration: BoxDecoration(),
                            child: Image.asset(
                                "images/home/cd-mine-43e5492b.png",
                                height: 120,
                                width: 120,
                                fit: BoxFit.cover),
                          )),
                    ),
                    Positioned(
                        top: 22,
                        left: -38,
                        child: RotationTransition(
                          turns: _playerController,
                          alignment: Alignment.center,
                          child: Container(
                            width: 77,
                            height: 77,
                            alignment: Alignment.topCenter,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    'https://p3.music.126.net/HaZXKgb5D_0Q_7FoxfCL-A==/109951167995289964.jpg?param=200y200'),
                                fit: BoxFit.cover,
                              ),
                              shape: BoxShape.rectangle,
                              borderRadius: new BorderRadius.all(
                                const Radius.circular(70), // 设置图片为圆形
                              ),
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            ],
          ),
          Column(
            // mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [userMusicText, userAuthor],
          ),
          Column(
              // mainAxisSize: MainAxisSize.min,
              )
        ],
      ),
    );
  }
}
