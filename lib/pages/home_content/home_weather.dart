import 'dart:async';
import 'package:flutter/material.dart';

class StarkWeather extends StatefulWidget {
  const StarkWeather({Key? key}) : super(key: key);
  @override
  _userPageContent createState() => _userPageContent();
}

class _userPageContent extends State<StarkWeather> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 450,
      height: 450,
      margin: const EdgeInsets.only(right: 10, top: 10),
    );
  }
}
