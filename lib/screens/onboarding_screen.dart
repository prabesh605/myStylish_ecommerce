import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stylish_ecommerce/screens/user_model/dashboard_page.dart';
import 'package:stylish_ecommerce/screens/login_screen.dart';
import 'package:stylish_ecommerce/screens/splash_or_onboarding_screens/materialsfor_splash_screen.dart';
import 'package:stylish_ecommerce/screens/splash_or_onboarding_screens/splash_screen1.dart';
import 'package:stylish_ecommerce/screens/splash_or_onboarding_screens/splash_screen2.dart';
import 'package:stylish_ecommerce/screens/splash_or_onboarding_screens/splash_screen3.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  //pagecontroller
  final PageController _pageController = PageController();
  //screen Index,
  int _screenIndex = 0;

  // screens list
  final List<Widget> _splashScreenCount = [
    SplashScreen1(),
    SplashScreen2(),
    SplashScreen3(),
  ];

  //disposing pagecontroller
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //height & weight from mediaquery
    final double mHeight = MediaQuery.sizeOf(context).height;
    final double mWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: white,
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        height: mHeight,
        width: mWidth,
        child: Stack(
          children: [
            //bottom layer
            PageView(
              onPageChanged: (int value) {
                setState(() {
                  _screenIndex = value;
                });
              },
              controller: _pageController,

              children: [
                AnimatedOpacity(
                  duration: Duration(seconds: 1),
                  opacity: _screenIndex == 0 ? 1 : 0.0,
                  child: _splashScreenCount[0],
                ),
                AnimatedOpacity(
                  duration: Duration(seconds: 1),
                  opacity: _screenIndex == 1 ? 1 : 0.0,
                  child: _splashScreenCount[1],
                ),
                AnimatedOpacity(
                  duration: Duration(seconds: 1),
                  opacity: _screenIndex == 2 ? 1 : 0.0,
                  child: _splashScreenCount[2],
                ),
              ],
            ),

            // headSection
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsetsGeometry.only(top: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: ' ${_screenIndex + 1}',
                              style: TextStyle(fontSize: 18, color: black),
                            ),
                            TextSpan(
                              text: '/3',
                              style: TextStyle(fontSize: 18, color: grey),
                            ),
                          ],
                        ),
                      ),

                      customTextButton(
                        title: 'Skip',
                        textColor: black,
                        callback: () {
                          _pageController.animateToPage(
                            _splashScreenCount.length - 1,
                            duration: Duration(milliseconds: 350),
                            curve: Curves.linear,
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 65,
                        child: _screenIndex == 0
                            ? Text('')
                            : customTextButton(
                                title: 'Prev',
                                textColor: darkPink,
                                callback: () {
                                  _pageController.animateToPage(
                                    _screenIndex - 1,
                                    duration: Duration(milliseconds: 350),
                                    curve: Curves.linear,
                                  );
                                },
                              ),
                      ),

                      SizedBox(
                        width: 80,
                        child: Row(
                          children: List.generate(_splashScreenCount.length, (
                            int index,
                          ) {
                            return AnimatedContainer(
                              duration: Duration(milliseconds: 350),
                              height: 10,
                              width: _screenIndex == index ? 40 : 10,
                              margin: EdgeInsets.symmetric(horizontal: 2),
                              decoration: BoxDecoration(
                                color: _screenIndex == index ? darkBlue : grey,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            );
                          }),
                        ),
                      ),
                      SizedBox(
                        width: 65,
                        child: customTextButton(
                          title: _screenIndex == _splashScreenCount.length - 1
                              ? 'Done'
                              : 'Next',
                          textColor: darkPink,
                          callback: () async {
                            _pageController.animateToPage(
                              _screenIndex + 1,
                              duration: Duration(milliseconds: 350),
                              curve: Curves.linear,
                            );
                            if (_screenIndex == _splashScreenCount.length - 1) {
                              SharedPreferences seenCheck =
                                  await SharedPreferences.getInstance();
                              await seenCheck.setBool('seenCheckvalue', true);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
