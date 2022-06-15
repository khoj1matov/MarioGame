import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Mushroom extends StatelessWidget {
  const Mushroom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 50,
      child: SvgPicture.asset(
        "assets/images/mushroom.svg",
        color: const Color.fromARGB(255, 80, 49, 3),
      ),
    );
  }
}
