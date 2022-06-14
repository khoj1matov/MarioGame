import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  Animation<Color?>? colorAnimation;
  Animation<Alignment?>? alignmentAnimation;

  Color colorOfContainer = Colors.black;
  double widthOfContainer = 100;
  double hightOfContainer = 100;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      lowerBound: 0.0,
      upperBound: 1.0,
      duration: const Duration(seconds: 2),
    );

    animationController!.forward();

    animationController!.addListener(() {
      setState(() {});
    });

    animationController!.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          animationController!.reverse();
        }
        if (status == AnimationStatus.forward ||
            status == AnimationStatus.dismissed) {
          animationController!.forward();
        }
      },
    );

    colorAnimation = ColorTween(
      begin: Colors.teal,
      end: Colors.red,
    ).animate(
      CurvedAnimation(
        parent: animationController!,
        curve: Curves.bounceIn,
      ),
    );

    alignmentAnimation = AlignmentTween(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).animate(
      CurvedAnimation(
        parent: animationController!,
        curve: Curves.bounceInOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorAnimation!.value,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            AnimatedRotation(
              turns: animationController!.value,
              duration: const Duration(seconds: 2),
              curve: Curves.bounceIn,
              child: Stack(
                children: [
                  Container(
                    alignment: alignmentAnimation!.value,
                    height: 200 * animationController!.value,
                    width: 200 * animationController!.value,
                    color: Colors.green.withOpacity(animationController!.value),
                    child: Container(
                      height: 50 * animationController!.value,
                      width: 50 * animationController!.value,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/mario1.png"),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
