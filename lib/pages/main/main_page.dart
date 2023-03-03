import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:window_manager/window_manager.dart';
import 'package:stark_genie/socket_util/socket_util.dart';

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
      _hideWindow();
    });
  }

  @override
  void _handleInitSocket() {
    WebSocketUtility().initWebSocket(1, onOpen: () {
      WebSocketUtility().initHeartBeat();
    }, onMessage: (data) {
      print(data);
    }, onError: (e) {
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
