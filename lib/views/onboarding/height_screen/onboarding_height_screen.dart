import 'package:bfit_tracker/theme.dart';
import 'package:bfit_tracker/views/onboarding/height_screen/widgets/onboarding_height_stack.dart';
import 'package:flutter/material.dart';

class OnboardingHeightScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainTheme.primaryColor,
      body: SafeArea(
        child: OnboardingHeightStack(),
      ),
    );
  }
}
