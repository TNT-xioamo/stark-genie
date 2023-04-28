import 'dart:async';
import 'package:flutter/material.dart';

class StarkLive extends StatefulWidget {
  const StarkLive({Key? key}) : super(key: key);
  @override
  _userPageContent createState() => _userPageContent();
}

class _userPageContent extends State<StarkLive> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 450,
      height: 450,
      margin: const EdgeInsets.only(right: 10, top: 10),
    );
  }
}
