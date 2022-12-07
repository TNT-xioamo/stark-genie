import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    super.initState();
    new Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed("/StarkLogin");
    });
  }

  @override
  Widget build(BuildContext context) {
    //启动图片
    return new Image(image: AssetImage("images/4.x/home_qd.jpg"),width: 100,height: 100,);
  }
}
