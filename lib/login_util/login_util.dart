import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:Stark/server/dio_util/dio_method.dart';
import 'package:Stark/server/dio_util/dio_response.dart';
import 'package:Stark/server/dio_util/dio_util.dart';

class LogintUtility {
  late var prefs;
  late var _username;
  late var _password;
  late Function onError;
  late Function onSuccess;
  late Timer _timer;

  void initUser({Function? onError, Function? onSuccess}) async {
    this.onError = onError!;
    this.onSuccess = onSuccess!;
    prefs = await SharedPreferences.getInstance();
    _username = prefs.getString('user_phone') ?? '';
    _password = prefs.getString('user_password') ?? '';
    if (_username == '' || _password == '') return handleError('');
    handleLogin();
  }

  void handleLogin() async {
    DioResponse result = await DioUtil().request(
      "/user/user/auth",
      method: DioMethod.post,
      data: {"username": _username, "password": _password},
    );
    var data = new Map<String, dynamic>.from(result.data);
    if (data['code'] != 200) return handleError(data['msg']);
    final setTokenResult =
        await prefs.setString('user_token', data['data']['refreshToken']);
    await prefs.setInt('user_id', data['data']['userId']);
    // handleSuccess(data);
    handleUserInfo();
  }

  void handleSuccess(data) => onSuccess();

  void handleError(mag) => onError(mag);

  void handleTimer() {
    _timer = Timer.periodic(Duration(milliseconds: 1800000), (timer) {
      ///定时任务
      handleLogin();
    });
  }

  void disposeCancel() {
    _timer.cancel();
  }

  void handleUserInfo() async {
    DioResponse result = await DioUtil()
        .request("/user/user/queryUserInfo", method: DioMethod.post);
    var data = new Map<String, dynamic>.from(result.data);
    if (data['code'] != 200) return handleError(data['msg']);
    print(data['data']['name']);
    await prefs.setString('user', data['data']['name']);
    handleSuccess(data['data']);
  }
}

// RequestOptions