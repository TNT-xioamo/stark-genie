import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:Stark/server/dio_util/dio_method.dart';
import 'package:Stark/server/dio_util/dio_response.dart';
import 'package:Stark/server/dio_util/dio_util.dart';

class StarkWeather extends StatefulWidget {
  const StarkWeather({Key? key}) : super(key: key);
  @override
  _userPageContent createState() => _userPageContent();
}

class _userPageContent extends State<StarkWeather> {
  var geoInfo = {};

  @override
  void initState() {
    _handleWeather();
  }

  @override
  void _handleGetIp() async {
    DioResponse result = await DioUtil().request(
      'https://ip.useragentinfo.com/json',
      method: DioMethod.get,
    );
    var data = jsonDecode(result.data);
    if (data['code'] != 200) return;
    setState(() {
      geoInfo = data;
    });
  }

  // https://restapi.amap.com/v3/weather/weatherInfo?
  @override
  void _handleWeather() async {
    // Options options = Options(headers: {'Referer': 'http://www.weather.com.cn/'});
    var day = new DateTime.now().millisecondsSinceEpoch;
    DioResponse result = await DioUtil().request(
        'https://www.yiketianqi.com/free/day?appid=43431598&appsecret=ffeKb5YG&unescape=1',
        method: DioMethod.get);
    // var data = jsonDecode(result.data);
    var data = new Map<String, dynamic>.from(result.data);
    setState(() {
      geoInfo = data;
    });
    // var el = geoInfo['data'].where((el) => )
    // print('====${data}====');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 450,
      height: 95,
      margin: const EdgeInsets.only(right: 10, top: 10),
      padding: const EdgeInsets.only(top: 10),
      decoration: new BoxDecoration(
          borderRadius: new BorderRadius.all(const Radius.circular(11.0)),
          color: Color.fromARGB(202, 255, 255, 255)),
      child: Row(children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 10),
              decoration: BoxDecoration(),
              child: Image.asset("images/home/WechatIMG75.jpeg",
                  height: 80, width: 120, fit: BoxFit.cover),
            )
          ],
        ),
        Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 25),
              decoration: BoxDecoration(),
              child: Column(
                children: <Widget>[
                  Row(children: [
                    Text(
                        ' ${geoInfo['city']} ${geoInfo['date']} ${geoInfo['week']}',
                        style:
                            TextStyle(color: Color.fromARGB(199, 46, 74, 81)))
                  ]),
                  Row(children: [
                    Text(
                        '天气状况: ${geoInfo['wea']}, 温度: ${geoInfo['tem']}°C - ${geoInfo['tem_day']}°C',
                        style: TextStyle(
                          color: Color.fromARGB(199, 46, 74, 81),
                          height: 1.7,
                        ))
                  ]),
                  Row(children: [
                    Text(
                        '出行指数: ${geoInfo['win']} / ${geoInfo['win_speed']} / ${geoInfo['win_meter']}',
                        style: TextStyle(
                          color: Color.fromARGB(199, 46, 74, 81),
                          height: 1.7,
                        ))
                  ])
                ],
              ),
            ),
          ],
        ),
        Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 25),
              child: Icon(
                Icons.place,
                color: Color.fromARGB(255, 67, 255, 246),
                size: 32,
              ),
            )
          ],
        )
      ]),
    );
  }
}
