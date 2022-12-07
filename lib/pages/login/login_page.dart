import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class StarkLogin extends StatelessWidget {
  const StarkLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(Icons.account_circle, size: 24),
        ),
        Row(children: [
          Text(
            'Flutter McFlutter',
            style: Theme.of(context).textTheme.headline5,
          ),
        ])
      ],
    );
  }
}
