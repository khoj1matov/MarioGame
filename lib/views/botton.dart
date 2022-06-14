import 'package:flutter/material.dart';

class MyButtonMario extends StatelessWidget {
  Widget? child;
  dynamic function;
  static bool holdingButton = false;

  MyButtonMario({Key? key, this.child, this.function}) : super(key: key);

  bool userIsHoldingButton() {
    return holdingButton;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        holdingButton = true;
        function();
      },
      onTapUp: (details) {
        holdingButton = false;
      },
      onTap: function,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.all(10),
          color: Colors.brown[300],
          child: child,
        ),
      ),
    );
  }
}
