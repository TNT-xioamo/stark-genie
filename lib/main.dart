import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
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
  WindowOptions windowOptions = WindowOptions(
    size: Size(328, 529),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  await localNotifier.setup(
    appName: 'stark-genie',
    // 仅 Windows
    shortcutPolicy: ShortcutPolicy.requireCreate,
  );
  runApp(const MacosUIGalleryApp());
}

class MyApp extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class MacosUIGalleryApp extends StatefulWidget {
  const MacosUIGalleryApp({Key? key}) : super(key: key);
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<MacosUIGalleryApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    // super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.paused) {
      // 应用进入后台
    } else if (state == AppLifecycleState.resumed) {
      // 应用进入前台
    } else if (state == AppLifecycleState.inactive) {
      // 应用进入非活动状态
    } else if (state == AppLifecycleState.detached) {
      // 应用退出
      final prefs = await SharedPreferences.getInstance();
      prefs.clear();
      // 在这里进行清理操作
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stark',
      debugShowCheckedModeBanner: false,
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
