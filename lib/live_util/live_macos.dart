import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:camera_universal/camera_universal.dart';

GlobalKey<_userPageStarkLive> liveMac = GlobalKey();

class StarkLiveMac extends StatefulWidget {
  const StarkLiveMac({Key? key}) : super(key: key);
  @override
  _userPageStarkLive createState() => _userPageStarkLive();
}

class _userPageStarkLive extends State<StarkLiveMac> {
  CameraController cameraController = CameraController();
  String error_msg = "";

  @override
  void initState() {
    super.initState();
    task();
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  Future<void> task() async {
    try {
      await cameraController.initializeCameras();
      await cameraController.initializeCamera(
        setState: setState,
      );
      await cameraController.activateCamera(
        setState: setState,
        mounted: () {
          return mounted;
        },
      );
    } catch (e) {
      print(e);
      setState(() {
        error_msg = "error";
      });
    }
  }

  void openLiveCamera() async {
    print('3123123');
    cameraController.action_change_camera(
      camera_id: 1,
      setState: setState,
      mounted: () {
        return mounted;
      },
      onCameraNotInit: () {},
      onCameraNotSelect: () {},
      onCameraNotActive: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 700,
        height: 310,
        margin: const EdgeInsets.only(right: 0, top: 0),
        decoration: new BoxDecoration(
            borderRadius: new BorderRadius.all(const Radius.circular(11.0)),
            color: Color.fromARGB(201, 171, 38, 38)),
        child: Visibility(
            visible: error_msg.isEmpty,
            replacement: Text(error_msg),
            child: Camera(
              cameraController: cameraController,
              onCameraNotInit: (context) {
                return Text("Camera not init");
              },
              onCameraNotSelect: (context) {
                return Text("Camera not select");
              },
              onCameraNotActive: (context) {
                return Text("Camera not active");
              },
              onPlatformNotSupported: (context) {
                return Text("Camera not supported");
              },
            )));
  }
}
