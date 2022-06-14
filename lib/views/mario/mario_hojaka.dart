import 'package:flutter/material.dart';

class MarioHojakaView extends StatefulWidget {
  const MarioHojakaView({Key? key}) : super(key: key);

  @override
  State<MarioHojakaView> createState() => _MarioHojakaViewState();
}

class _MarioHojakaViewState extends State<MarioHojakaView> {
  bool gameOver = false;
  int ball = 0;
  double _jump = 1;
  double _containerSpeed = 1.6;
  @override
  void initState() {
    super.initState();
    next();
    gameOverShowDialog(context);
    ballMario();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        child: Column(
          children: [
            Expanded(
              flex: 6,
              child: Container(
                color: Colors.blue,
                child: Stack(
                  children: [
                    //mario
                    Container(
                      alignment: Alignment(-0.7, _jump),
                      child: Image.asset(
                        'assets/images/run_forward.gif',
                        height: 100,
                      ),
                    ),
                    //Container
                    Align(
                      alignment: Alignment(_containerSpeed, 1),
                      child: Image.asset(
                        'assets/images/mario_wall.png',
                        height: 80,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                color: Colors.green,
                alignment: Alignment.center,
                child: Text(
                  "$ball",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        onTap: () async {
          gameOverShowDialog(context);
          for (var i = 0; i < 16; i++) {
            if (gameOver == false) {
              if (i < 8) {
                await Future.delayed(
                  const Duration(milliseconds: 100),
                  () {
                    _jump -= 0.1;
                    setState(() {});
                  },
                );
              } else {
                await Future.delayed(
                  const Duration(milliseconds: 100),
                  () {
                    _jump += 0.1;
                    gameOverShowDialog(context);
                    setState(() {});
                  },
                );
              }
            } else {
              break;
            }
          }
        },
      ),
    );
  }

  next() async {
    for (var i = 0; i <= i; i++) {
      if (gameOver == false) {
        await Future.delayed(const Duration(milliseconds: 100), () {
          _containerSpeed -= 0.1;
          // sakrashi
          if (_containerSpeed <= -1.6) {
            _containerSpeed = 1.6;
          }
          gameOverShowDialog(context);
        });
      } else {
        break;
      }
      setState(() {});
    }
  }

  ballMario() async {
    for (var i = 0; i <= ball; i++) {
      if (gameOver == false) {
        await Future.delayed(const Duration(milliseconds: 100), () {
          ball += 1;
          setState(() {});
        });
      } else {
        break;
      }
    }
  }

  gameOverShowDialog(BuildContext context) async {
    // kelib urilib teyib qolishi
    if (_containerSpeed <= -0.35) {
      // sakrab otvotkanda teyib qolishi
      if (_containerSpeed >= -1) {
        //sakraganda teyib qolishi
        if (_jump >= 0.65) {
          gameOver = true;
          showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text("GAME OWER"),
                    Text('You Ball: $ball'),
                    IconButton(
                      color: Colors.green,
                      icon: const Icon(Icons.refresh, size: 30),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const MarioHojakaView(),
                            ),
                            (route) => false);
                      },
                    )
                  ],
                ),
              );
            },
          );
          setState(() {});
        }
      }
    }
    setState(() {});
  }
}
