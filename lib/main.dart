import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:local_notifier/local_notifier.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'pages/login/login_page.dart';
import 'pages/home_loading/loading.dart';
import 'pages/main/main_page.dart';
import 'package:window_manager/window_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  // 添加自定义标题栏
  // WindowManager.addFrameWidget(MyTitleBar());
  WindowOptions windowOptions = WindowOptions(
    size: Size(910, 630),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  windowManager.setResizable(false);
  await localNotifier.setup(
    appName: 'stark-genie',
    // 仅 Windows
    shortcutPolicy: ShortcutPolicy.requireCreate,
  );
  SystemChannels.textInput.invokeMethod('TextInput.hide'); // 禁用IME输入法
  runApp(const MacosUIGalleryApp());
}

class MyApp extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class MacosUIGalleryApp extends StatefulWidget {
  const MacosUIGalleryApp({Key? key, camera})
      : super(
          key: key,
        );

  @override
  _AppState createState() => _AppState();
}

class MyTitleBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40.0,
        color: Colors.grey[200],
        child: Row(children: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () => exit(0), // 点击关闭按钮时退出程序
          ),
          Expanded(
            child: Text(
              'My App',
              textAlign: TextAlign.center,
            ),
          ),
        ]));
  }
}

class _AppState extends State<MacosUIGalleryApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stark',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: [Locale('zh', ''), Locale('en', 'US')],
      home: new Scaffold(
        backgroundColor: Colors.cyan,
        body: new Center(child: const Loading()),
      ),
      theme: ThemeData(
        primaryColor: const Color(0xff303030),
        scaffoldBackgroundColor: const Color(0xFFebebeb),
        cardColor: const Color(0xff393a3f),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: <String, WidgetBuilder>{
        "/StarkLogin": (context) => const StarkLogin(),
        "/StarkHomePage": (context) => const StarkHomePage(),
      },
    );
  }
}
