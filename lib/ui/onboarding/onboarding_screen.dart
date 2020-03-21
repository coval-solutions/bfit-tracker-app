import 'package:bfit_tracker/ui/onboarding/onboarding_screen_one.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int height = 170;
  bool isMaleSelected;
  String personImagePath;

  @override
  void initState() {
    super.initState();
    isMaleSelected = true;
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingScreenOne();
  }
}