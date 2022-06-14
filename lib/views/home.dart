import 'dart:async';

import 'package:animation/views/block_money.dart';
import 'package:animation/views/botton.dart';
import 'package:animation/views/mario.dart';
import 'package:animation/views/mushroom.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static double marioX = 0;
  static double marioY = 1;
  double marioSize = 80;
  double mushroomX = 0.8;
  double mushroomY = 1.01;
  double time = 0;
  double height = 0;
  double initialHeight = marioY;
  String direction = "right";
  bool midJump = false;
  var gameFont = GoogleFonts.pressStart2p(
    textStyle: const TextStyle(color: Colors.white, fontSize: 20),
  );
  static double blockX = -0.3;
  static double blockY = 0.3;
  double moneyX = blockX;
  double moneyy = blockY;
  int money = 0;

  void checkIfAteMushrooms() {
    if ((marioX - mushroomX).abs() < 0.05 &&
        (marioY - mushroomY).abs() < 0.05) {
      setState(() {
        mushroomX = 2;
        marioSize = 120;
      });
    }
  }

  void preJump() {
    time = 0;
    initialHeight = marioY;
  }

  void jump() {
    if (midJump == false) {
      midJump = true;
      preJump();
      Timer.periodic(const Duration(milliseconds: 50), (timer) {
        time += 0.05;
        height = -4.9 * time * time + 5 * time;

        if (initialHeight - height > 1) {
          midJump = false;
          setState(() {
            marioY = 1;
          });
          timer.cancel();
        } else {
          setState(() {
            marioY = initialHeight - height;
          });
        }
      });
    }
  }

  void moveRight() {
    direction = "right";
    checkIfAteMushrooms();
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      checkIfAteMushrooms();
      if (MyButtonMario().userIsHoldingButton() == true &&
          (marioX + 0.04) < 1.2) {
        setState(() {
          marioX += 0.04;
        });
      } else {
        timer.cancel();
      }
    });
  }

  void moveLeft() {
    direction = "left";
    checkIfAteMushrooms();
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      checkIfAteMushrooms();
      if (MyButtonMario().userIsHoldingButton() == true &&
          (marioX - 0.04) > -1.2) {
        setState(() {
          marioX -= 0.04;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
          flex: 8,
          child: Stack(
            children: [
              Container(
                color: Colors.blue,
                child: AnimatedContainer(
                  alignment: Alignment(marioX, marioY),
                  duration: const Duration(microseconds: 0),
                  child: Mario(
                    direction: direction,
                    size: marioSize,
                  ),
                ),
              ),
              Container(
                alignment: Alignment(mushroomX, mushroomY),
                child: const Mushroom(),
              ),
              Container(
                alignment: Alignment(blockX, blockY),
                child: BlockMoney(),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text("MARIO", style: gameFont),
                          const SizedBox(height: 10),
                          Text("0000", style: gameFont),
                        ],
                      ),
                      Column(
                        children: [
                          Text("WORLD", style: gameFont),
                          const SizedBox(height: 10),
                          Text("1-1", style: gameFont),
                        ],
                      ),
                      Column(
                        children: [
                          Text("TIME", style: gameFont),
                          const SizedBox(height: 10),
                          Text("9999", style: gameFont),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            color: Colors.brown,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MyButtonMario(
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  function: moveLeft,
                ),
                MyButtonMario(
                  child: const Icon(
                    Icons.arrow_upward,
                    color: Colors.white,
                  ),
                  function: jump,
                ),
                MyButtonMario(
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                  function: moveRight,
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
