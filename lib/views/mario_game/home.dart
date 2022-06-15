import 'dart:async';
import 'package:animation/views/mario_game/block_money.dart';
import 'package:animation/views/mario_game/botton.dart';
import 'package:animation/views/mario_game/mario.dart';
import 'package:animation/views/mario_game/mushroom.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  static double marioX = 0;
  static double marioY = 1;
  double marioSize = 80;
  double mushroomX = 0.8;
  double mushroomY = 1.01;
  double time = 0;
  double range = 0;
  int? doubleToInt;
  double height = 0;
  double initialHeight = marioY;
  String direction = "right";
  bool midJump = false;
  var gameFont = GoogleFonts.pressStart2p(
    textStyle: const TextStyle(color: Colors.white, fontSize: 20),
  );
  static double blockX = -0.3;
  static double blockY = 0.38;
  double moneyX = blockX;
  double moneyY = 0.38;
  bool moneyBool = false;
  int money = 0;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      lowerBound: -1.0,
      upperBound: 1.0,
      duration: const Duration(seconds: 2),
    );

    animationController!.forward();

    animationController!.addListener(() {
      setState(() {});
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
                alignment: Alignment(moneyX, moneyY),
                child: const Icon(
                  Icons.attach_money,
                  color: Colors.amber,
                ),
              ),
              Container(
                alignment: Alignment(blockX, blockY),
                child: const BlockMoney(),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          _textMethod("MARIO"),
                          const SizedBox(height: 10),
                          _textMethod("\$$money"),
                        ],
                      ),
                      Column(
                        children: [
                          _textMethod("WORLD"),
                          const SizedBox(height: 10),
                          _textMethod("1-1"),
                        ],
                      ),
                      Column(
                        children: [
                          _textMethod("TIME"),
                          const SizedBox(height: 10),
                          _textMethod((time.toInt()).toString()),
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
                  icon: Icons.arrow_back,
                  function: moveLeft,
                ),
                MyButtonMario(
                  icon: Icons.arrow_upward,
                  function: jump,
                ),
                MyButtonMario(
                  icon: Icons.arrow_forward,
                  function: moveRight,
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  void checkIfAteMushrooms() {
    if ((marioX - mushroomX).abs() < 0.05 &&
        (marioY - mushroomY).abs() < 0.05) {
      setState(() {
        mushroomX = 2;
        marioSize = 120;
      });
    }
  }

  void moneyUp() async {
    if (moneyBool == false) {
      moneyBool = true;
      for (var i = 0; i < 10; i++) {
        await Future.delayed(const Duration(milliseconds: 50), () {
          moneyY -= 0.05;
          setState(() {});
          print(moneyY);
        });
      }
      moneyY = blockY;
      moneyBool = false;
      setState(() {});
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

        if (initialHeight - height < blockY &&
            (marioX <= -0.15 && marioX >= -0.55)) {
          midJump = false;
          setState(() {
            marioY = 1;
          });
          moneyUp();
          money += 1;
          timer.cancel();
        } else {
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

  Text _textMethod(String text) => Text(text, style: gameFont);
}
