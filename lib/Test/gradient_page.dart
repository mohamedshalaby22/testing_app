import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:animate_gradient/animate_gradient.dart';

class GradientPage extends StatefulWidget {
  const GradientPage({Key? key}) : super(key: key);

  @override
  State<GradientPage> createState() => _GradientPageState();
}

class _GradientPageState extends State<GradientPage> {
  String feeling = 'Fine';
  double currentValue = 1;

  String getTextStatus() {
    if (currentValue <= 1.5) {
      return 'Fine';
    } else if (currentValue <= 2.5) {
      return 'Sad';
    } else {
      return 'Angry';
    }
  }

  List<Color> colors() {
    if (currentValue > 4 && currentValue < 7) {
      return [
        const Color(0xffFDC830),
        const Color(0xffF37335),
      ];
    } else if (currentValue > 7) {
      return [
        const Color(0xff8360c3),
        const Color(0xff2ebf91),
      ];
    } else {
      return [
        Colors.pinkAccent,
        Colors.white,
      ];
    }
  }

  Widget animateGradient({required Widget child}) {
    if (currentValue > 4 && currentValue < 7) {
      return AnimateGradient(
        primaryColors: const [
          Color(0xffFDC830),
          Color(0xffF37335),
        ],
        secondaryColors: const [
          Color(0xff8360c3),
          Color(0xff2ebf91),
        ],
        child: child,
      );
    } else if (currentValue > 7) {
      return AnimateGradient(
        primaryColors: const [
          Color(0xffED213A),
          Color(0xff93291E),
        ],
        secondaryColors: const [
          Color(0xff659999),
          Color(0xfff4791f),
        ],
        child: child,
      );
    } else {
      return AnimateGradient(
        primaryColors: const [
          Colors.pinkAccent,
          Colors.white,
        ],
        secondaryColors: const [
          Color(0xff1f4037),
          Color(0xff99f2c8),
        ],
        child: child,
      );
    }
  }

  List<Color> getPrimaryColors() {
    print('Fired!');
    print(currentValue);
    setState(() {});
    if (currentValue < 2) {
      return [
        Colors.pinkAccent,
        Colors.white,
      ];
    } else if (currentValue < 3) {
      return [
        Colors.orange,
        Colors.white,
      ];
    } else if (currentValue == 3) {
      return [
        Colors.greenAccent,
        Colors.white,
      ];
    }
    return [];
  }

  Widget getGradientBackground() {
    if (currentValue <= 1.5) {
      return AnimateGradient(
        primaryColors: const [
          Colors.greenAccent,
          Colors.white,
        ],
        secondaryColors: [
          Colors.greenAccent.shade100,
          Colors.green.shade900,
        ],
      );
    } else if (currentValue <= 2.5) {
      return AnimateGradient(
        primaryColors: const [
          Colors.orange,
          Colors.white,
        ],
        secondaryColors: [
          Colors.orangeAccent.shade100,
          Colors.orange.shade900,
        ],
      );
    } else {
      return AnimateGradient(
        primaryColors: const [
          Colors.pinkAccent,
          Colors.white,
        ],
        secondaryColors: [
          Colors.pinkAccent.shade100,
          Colors.pink.shade900,
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Visibility(
          visible: currentValue <= 1.5,
          child: AnimateGradient(
            primaryColors: const [
              Colors.greenAccent,
              Colors.white,
            ],
            secondaryColors: [
              Colors.greenAccent.shade100,
              Colors.green.shade900,
            ],
          ),
        ),
        Visibility(
          visible: currentValue > 1.5 && currentValue <= 2.5,
          child: AnimateGradient(
            primaryColors: const [
              Colors.orange,
              Colors.white,
            ],
            secondaryColors: [
              Colors.orangeAccent.shade100,
              Colors.orange.shade900,
            ],
          ),
        ),
        Visibility(
            visible: currentValue > 2.5,
            child: AnimateGradient(
              primaryColors: const [
                Colors.pinkAccent,
                Colors.white,
              ],
              secondaryColors: [
                Colors.pinkAccent.shade100,
                Colors.pink.shade900,
              ],
            )),
        Padding(
          padding: const EdgeInsets.only(top: 120, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'How are you\nfeeling today?',
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    height: 1.3,
                    fontWeight: FontWeight.w600,
                    fontSize: 35),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.25),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 800),
                        child: Text(
                          getTextStatus(),
                          key: ValueKey(getTextStatus()),
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              height: 1.3,
                              fontWeight: FontWeight.w600,
                              fontSize: 35),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Slider(
                          min: 1,
                          max: 3,
                          activeColor: Colors.white.withOpacity(0.7),
                          inactiveColor: Colors.white.withOpacity(0.7),
                          value: currentValue,
                          onChanged: (value) {
                            setState(() {
                              currentValue = value;
                            });
                            print(currentValue);
                          }),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 0.1),
                  color: Colors.white.withOpacity(0.7),
                ),
                child: const Center(
                    child: Text(
                  'Get Started',
                  style: TextStyle(fontWeight: FontWeight.w600),
                )),
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
