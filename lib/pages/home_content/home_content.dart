import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import 'package:Stark/pages/home_content/home_calendar.dart';
import 'package:Stark/pages/home_content/home_music.dart';
import 'package:Stark/pages/home_content/home_aides.dart';
import 'package:Stark/pages/home_content/home_weather.dart';
import 'package:Stark/pages/home_content/home_live.dart';

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
          width: 910,
          margin: const EdgeInsets.only(left: 65),
          padding: const EdgeInsets.only(top: 30, left: 10),
          decoration: new BoxDecoration(
              borderRadius: new BorderRadius.all(const Radius.circular(11.0)),
              color: Color.fromARGB(106, 255, 255, 255)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(child: StarkMusic(key: ValueKey(322))),
                      Container(child: StarkWeather(key: ValueKey(332))),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        child: StarkCalendar(key: ValueKey(321)),
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      StarkAides(
                        key: ValueKey(323),
                      )
                    ],
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  StarkLive(
                    key: ValueKey(322),
                  )
                ],
              )
            ],
          )),
    );
  }
}
