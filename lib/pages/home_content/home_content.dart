import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import 'package:Stark/pages/home_content/home_calendar.dart';

class StarkMain extends StatefulWidget {
  const StarkMain({Key? key}) : super(key: key);
  @override
  _userPageContent createState() => _userPageContent();
}

class _userPageContent extends State<StarkMain> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          width: 900,
          margin: const EdgeInsets.only(left: 65),
          padding: const EdgeInsets.only(top: 30, left: 10),
          decoration: new BoxDecoration(
              borderRadius: new BorderRadius.all(const Radius.circular(11.0)),
              color: Color.fromARGB(106, 255, 255, 255)),
          child: Row(
            children: [
              Column(
                children: [
                  Container(
                    child: StarkCalendar(key: ValueKey(321)),
                  )
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [],
              ),
              Column(
                children: [Text('3')],
              ),
            ],
          )),
    );
  }
}
