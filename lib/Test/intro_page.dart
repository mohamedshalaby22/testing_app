import 'package:flutter/material.dart';
import 'package:slide_to_act/slide_to_act.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff016bfd),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Container(
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 0.01)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 70, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Icon(
                    Icons.message,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Xchat',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Container(
                  width: 500,
                  height: 400,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 0.2)),
                ),
                Container(
                  width: 500,
                  height: 300,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 0.2)),
                ),
                Container(
                  width: 500,
                  height: 250,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 0.2)),
                ),
                Container(
                  width: 500,
                  height: 200,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 0.2)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 260),
            child: Align(
              alignment: Alignment.center,
              child: Transform.rotate(
                angle: 0.8,
                child: Container(
                  width: 80,
                  height: double.infinity,
                  color: const Color(0xff0b72ff),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 260),
            child: Align(
              alignment: Alignment.center,
              child: Transform.rotate(
                angle: -0.8,
                child: Container(
                  width: 80,
                  height: double.infinity,
                  color: const Color(0xff0b72ff),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 250),
            child: Align(
              alignment: Alignment.center,
              child: Transform.rotate(
                angle: -0.2,
                child: Image.asset(
                  'assets/images/dog3.png',
                  width: 80,
                  height: 80,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 450, right: 40),
            child: Align(
              alignment: Alignment.centerRight,
              child: Transform.rotate(
                angle: 0.2,
                child: Image.asset(
                  'assets/images/dog2.png',
                  width: 85,
                  height: 85,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 450, left: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Transform.rotate(
                angle: -0.2,
                child: Image.asset(
                  'assets/images/dog1.png',
                  width: 115,
                  height: 115,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 400, left: 45),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Image.asset(
                'assets/images/dog4.png',
                width: 85,
                height: 85,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 315),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Image.asset(
                'assets/images/dog5.png',
                width: 160,
                height: 160,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              height: 340,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(25))),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Express Your self with\n moji Expercience',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        height: 1.3,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Chat using avatar emoji gives a different\n impression, dare to try it',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 120,
                    child: SlideAction(
                      height: 60,
                      text: 'Swipe to start...',
                      outerColor: const Color(0xff016bfd),
                      sliderButtonIcon: const Icon(
                        Icons.keyboard_double_arrow_right,
                        color: Colors.blue,
                      ),
                      sliderButtonIconPadding: 12,
                      sliderRotate: false,
                      textStyle:
                          const TextStyle(fontSize: 20, color: Colors.white),
                      onSubmit: () {
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
/*







 */
