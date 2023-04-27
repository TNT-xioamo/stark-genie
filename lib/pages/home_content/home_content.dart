import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';

class StarkMain extends StatefulWidget {
  const StarkMain({Key? key}) : super(key: key);
  @override
  _userPageContent createState() => _userPageContent();
}

class _userPageContent extends State<StarkMain> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 65, top: 10),
      child: Text('123123'),
    );
  }
}
