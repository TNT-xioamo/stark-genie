import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/status.dart';
// import 'package:audioplayers/audioplayers.dart';

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
  late bool _isPlayIcon;

  @override
  void initState() {
    _playerController =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    _isPlayIcon = false;
    // ..addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     //动画从 controller.forward() 正向执行 结束时会回调此方法
    //     _playerController.reset();
    //     _playerController.forward();
    //   }
    // });
    super.initState();
  }

  @override
  void _onMusicPlay() {
    setState(() {
      _isPlayIcon = !_isPlayIcon;
      if (_isPlayIcon) {
        _playerController..repeat();
      } else {
        _playerController..reset();
      }
    });
  }

  @override
  Widget userMusicText = Container(
    padding: const EdgeInsets.only(top: 10),
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
        children: <Widget>[
          Column(
            children: <Widget>[
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
                    borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(7.0),
                      bottomLeft: const Radius.circular(7.0),
                      topRight: const Radius.circular(3),
                      bottomRight: const Radius.circular(3),
                    )),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Container(
                width: 70,
                height: 120,
                alignment: Alignment.topCenter,
                child: Stack(
                  children: <Widget>[
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[userMusicText, userAuthor],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: 140,
                child: Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        SizedBox(
                          width: 30,
                          child: FloatingActionButton(
                            heroTag: 'skip_previous',
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black12,
                            onPressed: () {},
                            child: const Icon(Icons.skip_previous),
                          ),
                        ),
                        SizedBox(width: 20)
                      ],
                    ),
                    Column(children: [
                      SizedBox(
                        width: 40,
                        child: FloatingActionButton(
                          heroTag: 'play_circle',
                          backgroundColor: Colors.white,
                          foregroundColor: Color.fromARGB(125, 1, 245, 249),
                          onPressed: () {
                            _onMusicPlay();
                          },
                          child: _isPlayIcon
                              ? const Icon(Icons.pause_circle)
                              : const Icon(Icons.play_circle),
                        ),
                      ),
                      SizedBox(width: 60)
                    ]),
                    Column(children: <Widget>[
                      SizedBox(
                        width: 30,
                        child: FloatingActionButton(
                          heroTag: 'skip_next',
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black12,
                          onPressed: () {},
                          child: const Icon(Icons.skip_next),
                        ),
                      )
                    ]),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
