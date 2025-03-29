import 'dart:async';
import 'package:flutter/material.dart';
import 'package:neo_pay/OnBoardingScreens/onboarding_screen_widgets.dart';
import 'package:neo_pay/global/colors.dart';
import 'package:neo_pay/global/global_widgets.dart';
import 'package:neo_pay/global/images.dart';
import 'package:neo_pay/global/text_styles.dart';
import 'package:neo_pay/main.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _mypagecontroller = PageController();
  int _selected_onboard = 0;
  int _currentPage = 0;
  List<Map<String, dynamic>> pages = [
    {
      'image': image_onboarding1,
      'image_size': displaysize.height * .19,
      'title': 'Send Money Across\nthe Globe',
      'subtitle':
          'Transfer money instantly, anytime, anywhere-fast, Secure, and hassle-free.'
    },
    {
      'image': image_onboarding2,
      'image_size': displaysize.height * .25,
      'title': 'Track  Control Your\nSpending',
      'subtitle':
          'Set monthly limits and get insights on where your money goes.'
    },
    {
      'image': image_onboarding3,
      'image_size': displaysize.height * .25,
      'title': 'Secure & Seamless\nTransactions',
      'subtitle':
          'Your money is safe with bank-grade security and instant transfers.'
    }
  ];
  @override
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {

      Timer.periodic(Duration(seconds: 3), (Timer timer) {
        if (_currentPage < pages.length - 1) {
          _currentPage++;
        } else {
          _currentPage = 0;
        }

        if (_mypagecontroller.hasClients) {
          // Check if attached
          _mypagecontroller.animateToPage(
            _currentPage,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      });
    });
  }

  @override
  void dispose() {
    _mypagecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: displaysize.height * .06),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(height: displaysize.height * .02),
                  Text("Welcome to",
                      style: CustomTextStyler().styler(
                          size: .035, type: 'S', color: neo_theme_blue0)),
                  SizedBox(height: displaysize.height * .03),
                  Image.asset(
                    image_app_logo,
                    height: displaysize.height * .075,
                  ),
                ],
              ),
              SizedBox(
                height: displaysize.height * .01,
              ),
              SizedBox(
                height: displaysize.height * .2,
                child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 500),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                    child: Image.asset(
                      key: UniqueKey(),
                      pages[_selected_onboard]['image'],
                      width: pages[_selected_onboard]['image_size'],
                    )),
              ),
              Column(
                children: [
                  SizedBox(
                    height: displaysize.height * .2,
                    width: displaysize.width,
                    child: PageView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      onPageChanged: (value) {
                        setState(() {
                          _selected_onboard = value;
                        });
                      },
                      itemCount: pages.length,
                      controller: _mypagecontroller,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: displaysize.width * .04),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(pages[index]['title'],
                                  style: CustomTextStyler().styler(
                                      size: .035,
                                      type: 'S',
                                      color: neo_theme_blue0)),
                              Text(pages[index]['subtitle'],
                                  style: CustomTextStyler().styler(
                                      size: .016,
                                      type: 'M',
                                      color: neo_theme_blue3)),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: displaysize.height * .02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (index) {
                      return Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: displaysize.width * .005),
                        height: displaysize.height * .006,
                        width: index == _selected_onboard
                            ? displaysize.width * .06
                            : displaysize.height * .006,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(displaysize.width / 4),
                          color: index == _selected_onboard
                              ? neo_theme_blue1
                              : neo_theme_grey1,
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: displaysize.height * .03),
                ],
              )
            ],
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: displaysize.height * .08,
          child: Padding(
            padding: EdgeInsets.only(
                bottom: displaysize.height * .02,
                left: displaysize.height * .02,
                right: displaysize.height * .02),
            child: ElevatedButton(
              onPressed: () {
                RegisterationBottomSheet(context);
              },
              style: CustomElevatedButtonTheme(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Get Started",
                      style: CustomTextStyler().styler(
                          size: .018, type: 'R', color: neo_theme_white0)),
                  SizedBox(
                    width: displaysize.width * .015,
                  ),
                  Image.asset(
                    icon_right_arrow,
                    height: displaysize.height * .03,
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
