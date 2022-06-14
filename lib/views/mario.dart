import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Mario extends StatelessWidget {
  final String? direction;
  double? size;

  Mario({Key? key, this.direction, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (direction == "right") {
      return SizedBox(
        width: size,
        height: size,
        child: Image.asset("assets/images/running.gif"),
      );
    } else {
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(pi),
        child: SizedBox(
          width: size,
          height: size,
          child: Image.asset("assets/images/running.gif"),
        ),
      );
    }
  }
}
