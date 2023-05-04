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
      width: 700,
      height: 320,
      margin: const EdgeInsets.only(right: 10, top: 10),
      decoration: new BoxDecoration(
          borderRadius: new BorderRadius.all(const Radius.circular(11.0)),
          color: Color.fromARGB(37, 0, 0, 0)),
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[Container()],
          ),
          Stack(children: <Widget>[
            Positioned(
                top: 0,
                left: 5,
                child: Container(
                  width: 56,
                  height: 25,
                  margin: const EdgeInsets.only(left: 10, top: 10),
                  decoration: new BoxDecoration(
                      borderRadius:
                          new BorderRadius.all(const Radius.circular(2.0)),
                      color: Color.fromARGB(37, 0, 0, 0)),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.fiber_manual_record,
                          size: 18, color: Color.fromARGB(255, 255, 45, 45)),
                      Text('Live', style: TextStyle(color: Colors.white))
                    ],
                  ),
                ))
          ]),
        ],
      ),
    );
  }
}
