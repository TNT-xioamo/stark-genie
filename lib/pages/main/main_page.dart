import 'dart:math';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:window_manager/window_manager.dart';
import 'package:Stark/socket_util/socket_util.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:local_notifier/local_notifier.dart';
import 'package:Stark/pages/system_user/system_user.dart';

class StarkHomePage extends StatefulWidget {
  const StarkHomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<StarkHomePage> {
  var webSocketUtility = null;
  @override
  void _hideWindow() {
    windowManager
        .minimize(); // will hide the window and the app will be running in the background
  }

  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      _handleInitSocket();
      // _hideWindow();
    });
    super.initState();
  }

  @override
  void dispose() {
    webSocketUtility?.closeSocket(status: 'none');
    super.dispose();
  }

  void _disposeSocket() {
    webSocketUtility?.closeSocket(status: 'none');
  }

  @override
  // 发送通知
  String? _localNot(data) {
    final notification = LocalNotification(
      identifier: '${data['id']}', // 用来生成通用唯一识别码
      title: data['title'] ?? '您有新的消息需要处理！',
      subtitle: '',
      body: data['message'],
      silent: false, // 用来设置是否静音
    );
    // 显示通知
    notification.onShow = () {};
    // 通知关闭
    notification.onClose = (even) {};
    // // 通知被点击了
    notification.onClick = () {
      notification.destroy();
    };
    // '你点击了通知的第$index个选项'
    notification.onClickAction = (index) {};
    notification.show();
  }

  @override
  void _handleInitSocket() async {
    final prefs = await SharedPreferences.getInstance();
    final user_id = await prefs.getInt('user_id');
    webSocketUtility = WebSocketUtility();
    webSocketUtility.initWebSocket(
        userId: user_id,
        onOpen: () {
          webSocketUtility.initHeartBeat();
        },
        onMessage: (data) {
          print('--${data}--');
          _localNot(data);
        },
        onError: (e) {
          var person = {
            "title": "系统断网提示",
            "id": Random().nextInt(100),
            "message": "请检查网络状态!"
          };
          _localNot(person);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: StarkSideways(
            key: ValueKey(320), editParentVoid: () => _disposeSocket()));
  }
}
