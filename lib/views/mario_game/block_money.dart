import 'package:flutter/material.dart';

class BlockMoney extends StatelessWidget {
  const BlockMoney({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        height: 50,
        width: 50,
        color: Colors.brown,
        child: const Icon(
          Icons.attach_money,
          color: Colors.white,
        ),
      ),
    );
  }
}
