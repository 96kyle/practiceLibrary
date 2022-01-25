import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:animated_text_kit/animated_text_kit.dart';

class SplashTest extends StatefulWidget {
  const SplashTest({Key? key}) : super(key: key);

  @override
  _SplashTestState createState() => _SplashTestState();
}

class _SplashTestState extends State<SplashTest> with TickerProviderStateMixin {
  int count = 0;
  String? title;

  final controller1 = TextEditingController();
  bool changeText = false;
  double fontSize = 20;
  Color color = Colors.red;

  late final AnimationController rotatedController = AnimationController(
    duration: Duration(seconds: 2),
    vsync: this,
  )..forward().whenCompleteOrCancel(() {
      setState(() {
        title = "SUBWAY";
        print(title);
      });
    });

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LayoutBuilder(builder: (context, constraint) {
          return Container(
            width: constraint.maxWidth,
            height: constraint.maxHeight,
            color: Colors.deepPurple,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                      right: 10,
                    ),
                    alignment: Alignment.centerRight,
                    child: AnimatedBuilder(
                      animation: rotatedController,
                      builder: (_, child) {
                        return Transform.rotate(
                          angle: rotatedController.value * 24 * math.pi,
                          child: child,
                        );
                      },
                      child: Icon(
                        Icons.commute_outlined,
                        size: 50,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: DefaultTextStyle(
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: Colors.blue,
                      ),
                      child: Container(
                        child: title != null
                            ? AnimatedTextKit(
                                isRepeatingAnimation: false,
                                animatedTexts: [
                                    TyperAnimatedText(
                                      '${title}',
                                      speed: Duration(milliseconds: 300),
                                    ),
                                  ])
                            : Container(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
