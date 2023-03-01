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
  handleToken() async{
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('user_token') ?? '';
    debugPrint('user_token: $token');
    if(token == ''){
      Navigator.of(context).pushNamedAndRemoveUntil('/StarkLogin', (route) => route == null,);
    }
  }
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
      child: Image.asset(
        "images/4x/home_qd.jpg",
        fit: BoxFit.fill,
      ),
    );
  }
}
