import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  handleToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('user_token');
    final token = prefs.getString('user_token') ?? '';
    // debugPrint('user_token: $token');
    debugPrint('===${token}===');
    if (token == '') {
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/StarkLogin',
        (route) => route == null,
      );
    } else {
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/StarkHomePage',
        (route) => route == null,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      handleToken();
      Navigator.of(context).pushReplacementNamed("/StarkLogin");
    });
  }

  @override
  Widget build(BuildContext context) {
    // 启动图片
    return Container(
      decoration: const BoxDecoration(color: Color.fromARGB(255, 67, 70, 66)),
      child: Column(
        children: <Widget>[],
      ),
    );
  }
}
