import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cherry_toast/cherry_toast.dart';

class StarkAides extends StatefulWidget {
  const StarkAides({Key? key}) : super(key: key);
  @override
  _userPageContent createState() => _userPageContent();
}

class _userPageContent extends State<StarkAides> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 57,
      height: 30,
      margin: const EdgeInsets.only(left: 20, top: 0),
      child: SizedBox(
        child: FloatingActionButton(
          heroTag: 'skip_prev',
          splashColor: Colors.deepPurple,
          backgroundColor: Color.fromARGB(151, 187, 84, 238),
          foregroundColor: Color.fromARGB(225, 255, 255, 255),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          onPressed: () {
            CherryToast.info(title: Text('此功能正在开发中')).show(context);
          },
          child: Text('助手', style: TextStyle(fontSize: 12.0)),
        ),
      ),
    );
  }
}
