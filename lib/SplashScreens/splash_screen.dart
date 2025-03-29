import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:neo_pay/OnBoardingScreens/onboarding_screen.dart';
import 'package:neo_pay/ShimmerPages/navigatorbar_shimmer.dart';
import 'package:neo_pay/global/images.dart';
import 'package:neo_pay/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _switchtoscreen();
  }

  _switchtoscreen() async {
    final prefs = await SharedPreferences.getInstance();
    
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    await Future.delayed(Duration(seconds: 3));
    if (isLoggedIn) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => NavigatorbarShimmer()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => OnboardingScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ZoomIn(
        delay: Duration(milliseconds: 1500),
        child: Center(
          child: Image.asset(
            image_app_logo,
            height: displaysize.height * .075,
          ),
        ),
      ),
    );
  }
}
