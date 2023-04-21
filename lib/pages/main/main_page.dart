import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:window_manager/window_manager.dart';
import 'package:stark_genie/socket_util/socket_util.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:local_notifier/local_notifier.dart';

class StarkHomePage extends StatefulWidget {
  const StarkHomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<StarkHomePage> {
  @override
  void _hideWindow() {
    windowManager
        .minimize(); // will hide the window and the app will be running in the background
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      _handleInitSocket();
    });
  }

  @override
  // 发送通知
  String? _localNot(value) {
    final notification = LocalNotification(
      // 用来生成通用唯一识别码
      identifier: '12345',
      title: '古诗鉴赏从',
      subtitle: '桃夭 - 佚名〔先秦〕',
      body: '桃之夭夭，灼灼其华。之子于归，宜其室家',
      // 用来设置是否静音
      silent: false,
    );
    // 显示通知
    notification.onShow = () {};
    // 通知关闭
    notification.onClose = (even) {};
    // // 通知被点击了
    notification.onClick = () {};
    // '你点击了通知的第$index个选项'
    notification.onClickAction = (index) {};
    notification.show();
  }

  @override
  void _handleInitSocket() async {
    final prefs = await SharedPreferences.getInstance();
    final user_id = await prefs.getInt('user_id');
    WebSocketUtility().initWebSocket(
        userId: user_id,
        onOpen: () {
          WebSocketUtility().initHeartBeat();
        },
        onMessage: (data) {
          print(data);
          _localNot(data);
        },
        onError: (e) {
          print(e);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Image.asset(
        "images/4x/home_qd.jpg",
        fit: BoxFit.fill,
      ),
    );
  }
}
