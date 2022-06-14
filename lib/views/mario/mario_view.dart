import 'package:flutter/material.dart';

class MarioView extends StatefulWidget {
  const MarioView({Key? key}) : super(key: key);

  @override
  State<MarioView> createState() => _MarioViewState();
}

class _MarioViewState extends State<MarioView>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;

  double _marioY = 1.0;
  double _yurish = 0;
  double _distanse = 1.0;

  @override
  void initState() {
    super.initState();
    _onLeft();
    _onRight();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 6,
            child: Container(
              alignment: Alignment.bottomCenter,
              color: Colors.blue,
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment(0, _marioY),
                    child: Image.asset(
                      "assets/images/run_forward.gif",
                      height: 80,
                      width: 80,
                    ),
                  ),
                  Container(
                    alignment: Alignment(_distanse, 1),
                    child: Image.asset(
                      "assets/images/mario_wall.png",
                      height: 70,
                      width: 70,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: InkWell(
              child: Container(
                color: Colors.green,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      child: const Icon(
                        Icons.arrow_circle_up,
                        size: 60,
                      ),
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: Colors.white12,
                      ),
                      onPressed: _onJump,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          child: const Icon(
                            Icons.arrow_circle_left_outlined,
                            size: 60,
                          ),
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            primary: Colors.white12,
                          ),
                          onPressed: _onLeft,
                        ),
                        ElevatedButton(
                          child: const Icon(
                            Icons.arrow_circle_right_outlined,
                            size: 60,
                          ),
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            primary: Colors.white12,
                          ),
                          onPressed: _onRight,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              onTap: _onJump,
            ),
          ),
        ],
      ),
    );
  }

  _onJump() async {
    for (var i = 0; i < 20; i++) {
      if (i < 10) {
        await Future.delayed(
          const Duration(milliseconds: 70),
          () {
            _marioY -= 0.1;
            setState(() {});
          },
        );
      } else {
        await Future.delayed(
          const Duration(milliseconds: 10),
          () {
            _marioY += 0.1;
            setState(() {});
          },
        );
      }
    }
  }

  _onLeft() {
    setState(() {});
    if (_distanse <= 0.35) {
      _yurish = _distanse;
      if (_yurish <= 0.35) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(
              title: Text("Game Over"),
            );
          },
        );
        setState(() {});
      }
      return _distanse = -1.0;
    }
    setState(() {});
    return _distanse += 0.2;
  }

  _onRight() {
    if (_distanse <= 0.35) {
      _yurish = _distanse;
      if (_yurish <= 0.35) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(
              title: Text("Game Over"),
            );
          },
        );
        setState(() {});
      }
      return _distanse = 1.0;
    }
    setState(() {});
    return _distanse -= 0.2;
  }
}


// @override
//   void initState() {
//     super.initState();
//     animationController = AnimationController(
//       vsync: this,
//       lowerBound: -1.0,
//       upperBound: 1.0,
//       duration: const Duration(seconds: 5),
//     );

//     animationController!.addListener(() {
//       setState(() {});
//     });

//     animationController!.addStatusListener(
//       (status) {
//         if (status == AnimationStatus.completed) {
//           animationController!.reverse();
//         }
//         if (status == AnimationStatus.forward ||
//             status == AnimationStatus.dismissed) {
//           animationController!.forward();
//         }
//       },
//     );
//   }