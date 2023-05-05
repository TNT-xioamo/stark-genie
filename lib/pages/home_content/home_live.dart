import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:camera_universal/camera_universal.dart';

import 'package:camera_macos/camera_macos_arguments.dart';
import 'package:camera_macos/camera_macos_controller.dart';
import 'package:camera_macos/camera_macos_device.dart';
import 'package:camera_macos/camera_macos_file.dart';
import 'package:camera_macos/camera_macos_method_channel.dart';
import 'package:camera_macos/camera_macos_platform_interface.dart';
import 'package:camera_macos/camera_macos_view.dart';
import 'package:camera_macos/exceptions.dart';
import 'package:camera_macos/extensions.dart';
import 'package:camera_macos/nskit_platform_view.dart';

class StarkLive extends StatefulWidget {
  const StarkLive({Key? key}) : super(key: key);
  @override
  _userPageContent createState() => _userPageContent();
}

class _userPageContent extends State<StarkLive> {
  bool isLive = false;
  String isMacOrWin = '';
  final GlobalKey cameraKey = GlobalKey(debugLabel: 'cameraKey');
  late CameraMacOSController macOSController;

  // CameraController cameraController = CameraController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isPlatform();
    // task();
  }

  // Future<void> task() async {
  //   await cameraController.initializeCameras();
  //   await cameraController.initializeCamera(
  //     setState: setState,
  //   );
  //   await cameraController.activateCamera(
  //     setState: setState,
  //     mounted: () {
  //       print(setState);
  //       return mounted;
  //     },
  //   );
  // }

  @override
  void dispose() {
    // cameraController.dispose();
    super.dispose();
  }

  void isPlatform() {
    if (Platform.isAndroid) {
      // Android
    } else if (Platform.isIOS) {
      // IOS
    } else if (Platform.isFuchsia) {
      // Fuchsia
    } else if (Platform.isWindows) {
      // Windows
      isMacOrWin = 'Windows';
    } else if (Platform.isMacOS) {
      // MacOS
      isMacOrWin = 'MacOS';
    } else if (Platform.isLinux) {
      // Linux
    }
  }

  @override
  void _onOpenLive() {
    // cameraController.action_get_camera_count(
    //   onCameraNotInit: () {},
    //   onCameraNotSelect: () {},
    //   onCameraNotActive: () {},
    // );
    // cameraController.action_change_camera(
    //   camera_id: 0,
    //   setState: setState,
    //   mounted: () {
    //     return mounted;
    //   },
    //   onCameraNotInit: () {},
    //   onCameraNotSelect: () {},
    //   onCameraNotActive: () {},
    // );
    setState(() async {
      isLive = !isLive;
    });
  }

  @override
  void _onOpenShare() {
    print('开启屏幕共享');
  }

  @override
  void _onOpenBeauty() {
    print('开启美颜');
  }

  @override
  void _onOpenMember() {
    print('查看成员');
  }

  @override
  Widget build(BuildContext context) {
    if (isMacOrWin != 'Windows' && isMacOrWin != 'MacOS') {
      print(isMacOrWin);
      return Container();
    }
    return Container(
      width: 770,
      height: 315,
      margin: const EdgeInsets.only(right: 10, top: 10),
      decoration: new BoxDecoration(
          borderRadius: new BorderRadius.all(const Radius.circular(11.0)),
          color: Color.fromARGB(0, 255, 255, 255)),
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                width: 700,
                height: 310,
                decoration: new BoxDecoration(
                    borderRadius:
                        new BorderRadius.all(const Radius.circular(11.0)),
                    color: Color.fromARGB(14, 130, 130, 130)),
                child: isLive
                    ? CameraMacOSView(
                        key: cameraKey,
                        fit: BoxFit.cover,
                        cameraMode: CameraMacOSMode.photo,
                        onCameraInizialized:
                            (CameraMacOSController controller) {
                          setState(() {
                            this.macOSController = controller;
                          });
                        },
                      )
                    : Container(),
                // child: Camera(
                //   cameraController: cameraController,
                //   onCameraNotInit: (context) {
                //     return const SizedBox.shrink();
                //   },
                //   onCameraNotSelect: (context) {
                //     return const SizedBox.shrink();
                //   },
                //   onCameraNotActive: (context) {
                //     return const SizedBox.shrink();
                //   },
                //   onPlatformNotSupported: (context) {
                //     return const SizedBox.shrink();
                //   },
                // ),
              )
            ],
          ),
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
                        size: 18,
                        color: isLive
                            ? Color.fromARGB(255, 45, 255, 209)
                            : Color.fromARGB(255, 255, 45, 45)),
                    Text('Live', style: TextStyle(color: Colors.white))
                  ],
                ),
              )),
          Positioned(
            top: 0,
            right: 20,
            child: Column(
              children: <Widget>[
                IconButton(
                    color: Colors.blue,
                    splashRadius: 20,
                    onPressed: _onOpenLive,
                    icon: const Icon(Icons.live_tv),
                    tooltip: isLive ? '关闭直播' : '开启视频',
                    iconSize: 25),
                IconButton(
                    color: Colors.blue,
                    splashRadius: 20,
                    onPressed: _onOpenBeauty,
                    icon: const Icon(Icons.add_reaction),
                    tooltip: '美颜',
                    iconSize: 25),
                IconButton(
                    color: Colors.blue,
                    splashRadius: 20,
                    onPressed: _onOpenMember,
                    icon: const Icon(Icons.perm_identity),
                    tooltip: '成员',
                    iconSize: 25),
                IconButton(
                    color: Colors.blue,
                    splashRadius: 20,
                    onPressed: _onOpenShare,
                    icon: const Icon(Icons.computer),
                    tooltip: '共享屏幕',
                    iconSize: 25),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
