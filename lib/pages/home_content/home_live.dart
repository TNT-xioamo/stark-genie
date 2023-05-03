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
      width: 650,
      height: 330,
      margin: const EdgeInsets.only(right: 10, top: 10),
      decoration: new BoxDecoration(
          borderRadius: new BorderRadius.all(const Radius.circular(11.0)),
          color: Color.fromARGB(38, 255, 255, 255)),
    );
  }
}
