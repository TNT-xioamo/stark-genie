import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;
import 'package:flutter_webrtc/flutter_webrtc.dart';

class StarkLive extends StatefulWidget {
  const StarkLive({Key? key}) : super(key: key);
  @override
  _userPageContent createState() => _userPageContent();
}

class _userPageContent extends State<StarkLive> {
  @override
  void initState() {
    // TODO: implement initState
    if (WebRTC.platformIsDesktop) {
      debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
    } else if (WebRTC.platformIsAndroid) {
      //startForegroundService();
    }
    super.initState();
  }

  @override
  void _onOpenLive() {
    print('开启直播');
  }

  @override
  void _onOpenShare() {
    print('开启屏幕共享');
  }

  @override
  void _onOpenBeauty() {
    print('开启美颜');
  }

  @override
  void _onOpenMember() {
    print('查看成员');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 770,
      height: 320,
      margin: const EdgeInsets.only(right: 10, top: 10),
      decoration: new BoxDecoration(
          borderRadius: new BorderRadius.all(const Radius.circular(11.0)),
          color: Color.fromARGB(0, 255, 255, 255)),
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                width: 700,
                height: 320,
                decoration: new BoxDecoration(
                    borderRadius:
                        new BorderRadius.all(const Radius.circular(11.0)),
                    color: Color.fromARGB(14, 130, 130, 130)),
              )
            ],
          ),
          Column(children: <Widget>[
            Positioned(
                top: 0,
                left: 5,
                child: Container(
                  width: 56,
                  height: 25,
                  margin: const EdgeInsets.only(left: 10, top: 10),
                  decoration: new BoxDecoration(
                      borderRadius:
                          new BorderRadius.all(const Radius.circular(2.0)),
                      color: Color.fromARGB(37, 0, 0, 0)),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.fiber_manual_record,
                          size: 18, color: Color.fromARGB(255, 255, 45, 45)),
                      Text('Live', style: TextStyle(color: Colors.white))
                    ],
                  ),
                ))
          ]),
          Positioned(
            top: 0,
            right: 20,
            child: Column(
              children: <Widget>[
                IconButton(
                    color: Colors.blue,
                    splashRadius: 20,
                    onPressed: _onOpenLive,
                    icon: const Icon(Icons.live_tv),
                    tooltip: '开启视频',
                    iconSize: 25),
                IconButton(
                    color: Colors.blue,
                    splashRadius: 20,
                    onPressed: _onOpenBeauty,
                    icon: const Icon(Icons.add_reaction),
                    tooltip: '美颜',
                    iconSize: 25),
                IconButton(
                    color: Colors.blue,
                    splashRadius: 20,
                    onPressed: _onOpenMember,
                    icon: const Icon(Icons.perm_identity),
                    tooltip: '成员',
                    iconSize: 25),
                IconButton(
                    color: Colors.blue,
                    splashRadius: 20,
                    onPressed: _onOpenShare,
                    icon: const Icon(Icons.computer),
                    tooltip: '共享屏幕',
                    iconSize: 25),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
