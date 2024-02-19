import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testing_app/Test/intro_page.dart';
import 'package:testing_app/Test/security_file_page.dart';
import 'encrypted_page.dart';
import 'glassy_navbar.dart';
import 'gradient_page.dart';

class AnimationPage extends StatefulWidget {
  const AnimationPage({Key? key}) : super(key: key);

  @override
  State<AnimationPage> createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage> {
  String btnText = 'Activate';
  String btn2Text = 'Activate';
  String btn3Text = 'Send';
  String savedText = 'Save';
  bool isActivated = false;
  bool isActivatedBtn = false;
  bool isWaiting = false;
  bool isSelected = false;
  bool isSent = false;
  bool isSentBtn = false;
  bool isSaved = false;
  bool isSavedBtn = false;
  bool isSavedCompleted = false;
  Color containerColor = Colors.grey[900]!;
  double turns = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    containerColor = Colors.grey[900]!;
                    btnText = 'Waiting';
                    isWaiting = true;
                    Future.delayed(const Duration(seconds: 1)).then((value) {
                      isWaiting = false;
                      isActivated = true;
                      btnText = 'Activated';
                      containerColor = Colors.green;
                      setState(() {});
                    });
                  });
                },
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 800),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    height: 58,
                    width: double.infinity,
                    key: ValueKey(containerColor),
                    decoration: BoxDecoration(
                      color: containerColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 35,
                          child: Visibility(
                            visible: isWaiting,
                            replacement: CircleAvatar(
                              radius: 17,
                              backgroundColor: Colors.white,
                              child: FadeInUp(
                                duration: Duration(
                                    milliseconds:
                                        btnText == 'Activated' ? 400 : 0),
                                child: Icon(
                                  (!isWaiting && isActivated)
                                      ? Icons.check
                                      : Icons.arrow_upward,
                                  color: (!isWaiting && isActivated)
                                      ? Colors.green
                                      : Colors.black,
                                ),
                              ),
                            ),
                            child: const CupertinoActivityIndicator(
                              radius: 10,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        FadeInUp(
                          duration: Duration(
                              milliseconds: btnText == 'Activated' ? 400 : 0),
                          child: Text(
                            btnText,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        const CircleAvatar(
                          radius: 17,
                          backgroundColor: Colors.transparent,
                          child: Icon(
                            Icons.check,
                            color: Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  if (isSelected) {
                    return;
                  }
                  setState(() {
                    isSelected = !isSelected;
                    btn2Text = 'Activated';
                    turns += 1;
                    Future.delayed(const Duration(seconds: 1)).then((value) {
                      isActivatedBtn = true;

                      setState(() {});
                    });
                  });
                },
                child: Container(
                  height: 58,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: (isSelected && isActivatedBtn)
                        ? Colors.green
                        : Colors.black,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Stack(
                    children: [
                      AnimatedPositioned(
                        left: isSelected
                            ? MediaQuery.of(context).size.width / 1.3
                            : 10,
                        top: 12,
                        curve: Curves.fastOutSlowIn,
                        duration: const Duration(seconds: 1),
                        child: CircleAvatar(
                          radius: 17,
                          backgroundColor: Colors.white,
                          child: AnimatedRotation(
                            turns: turns,
                            duration: const Duration(seconds: 1),
                            child: Icon(
                              (isSelected && isActivatedBtn)
                                  ? Icons.check
                                  : Icons.arrow_upward,
                              color: (isSelected && isActivatedBtn)
                                  ? Colors.green
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 15,
                        left: MediaQuery.of(context).size.width / 3 + 11.3,
                        child: FadeInUp(
                          key: btn2Text == 'Activated'
                              ? ValueKey(btn2Text)
                              : const ValueKey(''),
                          duration: Duration(
                              seconds: btn2Text == 'Activated' ? 1 : 0),
                          child: Text(
                            btn2Text,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      const CircleAvatar(
                        radius: 17,
                        backgroundColor: Colors.transparent,
                        child: Icon(
                          Icons.check,
                          color: Colors.transparent,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  if (isSent) {
                    return;
                  }
                  setState(() {
                    btn3Text = 'Sent';
                    isSent = !isSent;
                    turns += 0;
                    Future.delayed(const Duration(seconds: 1)).then((value) {
                      isSentBtn = true;
                      setState(() {});
                    });
                  });
                  setState(() {});
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 600),
                  height: 58,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color:
                        (isSentBtn && isSent) ? Colors.green : Colors.blue[400],
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      AnimatedPositioned(
                        curve: Curves.fastOutSlowIn,
                        duration: const Duration(seconds: 2),
                        left:
                            isSent ? MediaQuery.of(context).size.width / 1 : 10,
                        right: MediaQuery.of(context).size.width / 3 - 30,
                        child: Transform.rotate(
                          angle: isSent ? 0 : 18,
                          child: const Padding(
                            padding: EdgeInsets.only(bottom: 5),
                            child: Icon(
                              Icons.send_outlined,
                              size: 22,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      FadeIn(
                        key: btn3Text == 'Sent'
                            ? ValueKey(btn3Text)
                            : const ValueKey(''),
                        duration: Duration(seconds: btn3Text == 'Sent' ? 2 : 0),
                        child: Text(
                          btn3Text,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () async {
                  setState(() {
                    isSaved = true;
                  });
                  Future.delayed(const Duration(milliseconds: 600), () {
                    setState(() {
                      isSavedBtn = true;
                    });
                  }).then((value) {
                    Future.delayed(const Duration(milliseconds: 800), () {
                      setState(() {
                        isSaved = false;
                        savedText = 'Saved';
                      });
                    });
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 600),
                  height: isSaved ? 58 : 58,
                  width: isSaved ? 58 : 400,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: Visibility(
                      visible: isSaved && isSavedBtn,
                      replacement: FadeInLeft(
                        duration: Duration(milliseconds: isSavedBtn ? 800 : 0),
                        child: Text(
                          savedText,
                          key: isSavedBtn
                              ? ValueKey(savedText)
                              : const ValueKey(''),
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.white),
                        ),
                      ),
                      child: FadeInUp(
                        duration: const Duration(milliseconds: 600),
                        child: const Icon(
                          Icons.check,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TestEncryptedPage()));
                },
                child: Container(
                  height: 58,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.pinkAccent,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Center(
                    child: Text(
                      'Encrypt',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SecurityFilePage()));
                },
                child: Container(
                  height: 58,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.brown,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Center(
                    child: Text(
                      'Security File',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const GradientPage()));
                },
                child: Container(
                  height: 58,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [
                      Color(0xff3A1C71),
                      Color(0xffD76D77),
                      Color(0xffFFAF7B),
                    ]),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Center(
                    child: Text(
                      'Animated Gradient Colors',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const GlassBottomNavBar()));
                },
                child: Container(
                  height: 58,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Center(
                    child: Text(
                      'Glassy BottomNavBar',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const IntroPage()));
                },
                child: Container(
                  height: 58,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Center(
                    child: Text(
                      'Intro Page',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
