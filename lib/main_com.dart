import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:local_notifier/local_notifier.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

void main() async {
  debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
  WidgetsFlutterBinding.ensureInitialized();
  await localNotifier.setup(
    appName: 'stark-genie',
    // 仅 Windows
    shortcutPolicy: ShortcutPolicy.requireCreate,
  );
  runApp(const MacosUIGalleryApp());
}

class MacosUIGalleryApp extends StatelessWidget {
  const MacosUIGalleryApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stark',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
       home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter layout demo'),
        ),
        body: const Center(
          child: Text('你好'),
        ),
      )
    );
  }
}
