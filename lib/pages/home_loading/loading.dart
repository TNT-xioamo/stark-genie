import 'dart:async';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:Stark/login_util/login_util.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  handleToken() {
    LogintUtility().initUser(
      onError: goToLogin,
      onSuccess: goHome,
    );
  }

  void goHome() {
    Navigator.of(context).pushNamedAndRemoveUntil(
      '/StarkHomePage',
      (route) => route == null,
    );
  }

  void goToLogin() {
    Navigator.of(context).pushNamedAndRemoveUntil(
      '/StarkLogin',
      (route) => route == null,
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      handleToken();
      // Navigator.of(context).pushReplacementNamed("/StarkLogin");
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
