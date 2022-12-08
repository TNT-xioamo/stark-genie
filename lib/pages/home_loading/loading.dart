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
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed("/StarkLogin");
    });
  }

  @override
  Widget build(BuildContext context) {
    //启动图片
    return  Material(
      child:  Image.asset(
        "images/4x/home_qd.jpg",
        fit: BoxFit.cover,
      ),
    );
  }
}
