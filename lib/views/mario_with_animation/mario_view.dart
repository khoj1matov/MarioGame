import 'package:flutter/material.dart';

class MarioWithAnimationView extends StatefulWidget {
  const MarioWithAnimationView({Key? key}) : super(key: key);

  @override
  State<MarioWithAnimationView> createState() => _MarioWithAnimationViewState();
}

class _MarioWithAnimationViewState extends State<MarioWithAnimationView>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  AnimationController? animationControllerMario;
  bool isJump = false;
  double distance = 0;

  @override
  void initState() {
    super.initState();
    gameOverShowDialog(context);
    // ANIMATION CONTROLLER MARIO
    animationControllerMario = AnimationController(
      vsync: this,
      lowerBound: 0,
      upperBound: 170,
      duration: const Duration(milliseconds: 450),
    );

    animationControllerMario!.forward();
    animationControllerMario!.addListener(() {
      setState(() {});
    });
    animationControllerMario!.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          print("Complete");
          animationControllerMario!.reverse();
        }
      },
    );

    // ANIMATION CONTROLLER WALL
    animationController = AnimationController(
      vsync: this,
      lowerBound: 0,
      upperBound: 400,
      duration: const Duration(seconds: 2),
    );

    animationController!.forward();
    animationController!.addListener(() {
      distance = animationController!.value;
      setState(() {});
    });
    animationController!.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          print("Complete");
          animationController!.repeat();
        }
      },
    );
  }

  gameOverShowDialog(BuildContext context) async {
    if (distance > 380 && distance < 370) {
      animationController!.dispose();
      print("Ishladiiiiiiii");
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Text("GAME OWER"),
              ],
            ),
          );
        },
      );
      // setState(() {});
    }
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 8,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Stack(
                children: [
                  Positioned(
                    left: 20,
                    bottom: animationControllerMario!.value,
                    child: Image.asset(
                      "assets/images/run_forward.gif",
                      height: 80,
                      width: 80,
                    ),
                  ),
                  Positioned(
                    top: 600,
                    right: animationController!.value,
                    child: Image.asset(
                      "assets/images/mario_wall.png",
                      height: 50,
                      width: 50,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: InkWell(
              child: Container(
                color: Colors.brown,
              ),
              onTap: () {
                animationControllerMario!.forward();
                animationControllerMario!.addListener(() {
                  setState(() {});
                });
                animationControllerMario!.addStatusListener((status) {
                  if (status == AnimationStatus.completed) {
                    animationControllerMario!.reverse();
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
