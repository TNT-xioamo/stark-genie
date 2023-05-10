import 'dart:async';
// import 'dart:convert';
import 'dart:ffi' as ui;
import 'dart:math' as math;
import 'package:dio/dio.dart';
// import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:local_notifier/local_notifier.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:Stark/server/dio_util/dio_method.dart';
import 'package:Stark/server/dio_util/dio_response.dart';
import 'package:Stark/server/dio_util/dio_util.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:Stark/login_util/login_util.dart';
// import 'package:overlay_support/overlay_support.dart';

import 'package:shared_preferences/shared_preferences.dart';

class StarkLogin extends StatefulWidget {
  const StarkLogin({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<StarkLogin> {
  FocusNode _focusNodeUserName = new FocusNode();
  FocusNode _focusNodePassWord = new FocusNode();

  /// 用户输入框控制器 控制器监听用户输入框操作
  TextEditingController _userNameController = new TextEditingController();
  TextEditingController _userPassWordController = new TextEditingController();

  /// 表单状态
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var _password = ''; //用户名
  var _username = ''; //密码
  var _isShowPwd = false; //是否显示密码
  var _isShowClear = false; //是否显示输入框尾部的清除按钮
  var _isRemember = false;
  @override
  void initState() {
    /// TODO: implement initState
    /// 设置焦点监听
    _focusNodeUserName.addListener(_focusNodeListener);
    _focusNodePassWord.addListener(_focusNodeListener);

    /// 监听用户名框的输入改变
    _userNameController.addListener(() {
      // 监听文本框输入变化，当有内容的时候，显示清除按钮，否则不显示
      if (_userNameController.text.length > 0) {
        _isShowClear = true;
      } else {
        _isShowClear = false;
      }
      setState(() {});
    });
    if (_isRemember) initCache();
    super.initState();
  }

  Future initCache() async {
    CherryToast.success(title: Text('请使用内网环境')).show(context);
    // TextEditingController _userNameController = TextEditingController();
    // TextEditingController _pas = TextEditingController();
    final prefs = await SharedPreferences.getInstance();
    final phone = prefs.getString('user_phone') ?? '';
    final pas = prefs.getString('user_password') ?? '';
    _userNameController = TextEditingController.fromValue(TextEditingValue(
      text: _username.isEmpty ? phone : '',
    ));
    _userPassWordController = TextEditingController.fromValue(TextEditingValue(
      text: _password.isEmpty ? pas : '',
    ));
    // _username = prefs.getString('user_phone') ?? '';
    // _password = prefs.getString('user_password') ?? '';
    setState(() {});
  }

  @override
  void dispose() {
    /// TODO: implement initState
    /// 移除焦点监听
    _focusNodeUserName.removeListener(_focusNodeListener);
    _focusNodePassWord.removeListener(_focusNodeListener);
    _userNameController.dispose();
    super.dispose();
  }

  // 监听焦点
  Future<Null> _focusNodeListener() async {
    if (_focusNodeUserName.hasFocus) {
      print("用户名框获取焦点");
      _focusNodePassWord.unfocus();
    }
    if (_focusNodePassWord.hasFocus) {
      print("密码框获取焦点");
      _focusNodeUserName.unfocus();
    }
  }

  // 验证用户名
  String? validateUserName(value) {
    // 正则匹配手机号
    RegExp exp = RegExp(
        r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
    if (value.isEmpty) {
      return '用户名不能为空';
    } else if (!exp.hasMatch(value)) {
      return '请输入正确的手机号';
    }
    return null;
  }

  // 验证密码
  String? validatePassWord(value) {
    if (value.isEmpty) {
      return '密码不能为空';
    } else if (value.trim().length < 6 || value.trim().length > 18) {
      return '密码长度不正确';
    }
    return null;
  }

  // 发送通知
  String? _localNot(data) {
    final notification = LocalNotification(
      identifier: data?['id'] ?? '3a21', // 用来生成通用唯一识别码
      title: '欢迎使用stark',
      subtitle: '',
      body: data?['message'],
      silent: false, // 用来设置是否静音
    );
    notification.onShow = () {}; // 显示通知
    notification.onClose = (even) {}; // 通知关闭
    notification.onClick = () {
      notification.destroy();
    }; // 通知被点击了
    notification.onClickAction = (index) {}; // '你点击了通知的第$index个选项'
    notification.show();
  }

  /// 处理登陆
  void _handleLogin() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_phone', _username);
      await prefs.setString('user_password', _password);
      LogintUtility().initUser(
        onError: () =>
            CherryToast.success(title: Text('登录失败,请检查网络环境')).show(context),
        onSuccess: goHome,
      );
      // DioResponse result = await DioUtil().request(
      //   "/user/user/auth",
      //   method: DioMethod.post,
      //   data: {"username": _username, "password": _password},
      // );
      // var data = new Map<String, dynamic>.from(result.data);
      // debugPrint('===${data['msg']}===');
      // if (data['code'] != 200)
      //   return CherryToast.info(title: Text(data['msg'])).show(context);
      // final prefs = await SharedPreferences.getInstance();
      // final setTokenResult =
      //     await prefs.setString('user_token', data['data']['refreshToken']);
      // await prefs.setInt('user_id', data['data']['userId']);
      // await prefs.setString('user_phone', _username);
      // await prefs.setString('user_password', _password);
      // debugPrint('===${data['data']}===');
      // if (setTokenResult) {
      //   debugPrint('保存登录token成功');
      //   _localNot(data);
      //   Navigator.of(context).pushNamedAndRemoveUntil(
      //       '/StarkHomePage', (route) => route == null);
      //   return CherryToast.success(title: Text('登陆成功！')).show(context);
      // } else {
      //   debugPrint('error, 保存登录token失败');
      // }
      // Navigator.pushReplacement();
      // final Uri toLaunch = Uri.parse(
      //     'http://172.16.0.16:8000/#/login?token=${data['data']['refreshToken']}');
      // final Uri toLaunch = Uri(scheme: 'http', host: '172.16.0.16:8000', path: 'headers/');
      // _launchInBrowser(toLaunch);
    } catch (e) {
      print(e);
    }
    return null;
  }

  void goHome() {
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/StarkHomePage', (route) => route == null);
    _localNot({});
    // return CherryToast.success(title: Text('登陆成功！')).show(context);
  }

  // 唤醒浏览器
  Future<void> _launchInBrowser(url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_new
    Widget logoImageArea = Container(
      alignment: Alignment.topCenter,
      //  设置图片为圆形
      child: ClipOval(
        child: Image.asset("images/4x/logo.png",
            height: 100, width: 100, fit: BoxFit.cover),
      ),
    );

    // 输入文本框区域
    Widget inputTextArea = Container(
      margin: EdgeInsets.only(left: 300, right: 300),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.white),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            RawKeyboardListener(
              focusNode: FocusNode(),
              onKey: (RawKeyEvent event) {
                if (event.logicalKey == LogicalKeyboardKey.backspace &&
                    event is RawKeyDownEvent) {
                  setState(() {
                    final text = _userNameController.text;
                    if (text.isNotEmpty) {
                      _userNameController.text =
                          text.substring(0, text.length - 1);
                      _userNameController.selection =
                          TextSelection.fromPosition(
                        TextPosition(offset: _userNameController.text.length),
                      );
                    }
                  });
                }
              },
              child: TextFormField(
                controller: _userNameController,
                focusNode: _focusNodeUserName,
                keyboardType: TextInputType.number, // 键盘类型
                decoration: InputDecoration(
                  labelText: "用户名",
                  hintText: "请输入手机号",
                  prefixIcon: Icon(Icons.person),
                  suffixIcon: (_isShowClear) // 尾部清除按钮
                      ? IconButton(
                          onPressed: () {
                            _userNameController.clear(); // 清空输入框内容
                          },
                          icon: Icon(Icons.clear),
                        )
                      : null,
                ),
                // 验证用户名
                validator: validateUserName,
                // 保存数据
                onSaved: (String? value) {
                  _username = value!;
                },
              ),
            ),
            RawKeyboardListener(
              focusNode: FocusNode(),
              onKey: (RawKeyEvent event) {
                if (event.logicalKey == LogicalKeyboardKey.backspace &&
                    event is RawKeyDownEvent) {
                  setState(() {
                    final text = _userPassWordController.text;
                    if (text.isNotEmpty) {
                      _userPassWordController.text =
                          text.substring(0, text.length - 1);
                      _userPassWordController.selection =
                          TextSelection.fromPosition(
                        TextPosition(
                            offset: _userPassWordController.text.length),
                      );
                    }
                  });
                }
              },
              child: TextFormField(
                controller: _userPassWordController,
                focusNode: _focusNodePassWord,
                keyboardType: TextInputType.number, // 键盘类型
                decoration: InputDecoration(
                  labelText: "密码",
                  hintText: "请输入密码",
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(// 是否显示密码
                        (_isShowPwd) ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _isShowPwd = !_isShowPwd;
                      });
                    },
                  ),
                ),
                obscureText: !_isShowPwd,
                validator: validatePassWord, // 密码验证
                onSaved: (String? value) {
                  _password = value!; // 保存数据
                },
              ),
            ),
          ],
        ),
      ),
    );

    // 登陆 按钮
    Widget loginButtonArea = Container(
      margin: EdgeInsets.only(left: 470, right: 300),
      child: SizedBox(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              // minimumSize: Size(10, 50),
              backgroundColor: Color.fromARGB(255, 37, 128, 247),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60))),
          child: const Text("登录"),
          onPressed: () {
            //点击登录按钮，解除焦点，回收键盘
            _focusNodePassWord.unfocus();
            _focusNodeUserName.unfocus();
            if (_formKey.currentState!.validate()) {
              // 只有输入通过验证， 才会执行
              _formKey.currentState!.save();
              _handleLogin();
              // 登陆操作
            }
          },
        ),
      ),
    );
    // 第三方登录区域
    return Scaffold(
      backgroundColor: Colors.white,
      // 外层添加一个手势，用于点击空白部分，回收键盘
      body: GestureDetector(
        child: ListView(
          children: <Widget>[
            // ignore: prefer_const_constructors
            SizedBox(
              height: 80,
            ),
            logoImageArea,
            const SizedBox(height: 70),
            inputTextArea,
            // ignore: prefer_const_constructors
            SizedBox(
              height: 10,
            ),
            loginButtonArea
          ],
        ),
      ),
    );
  }
}
