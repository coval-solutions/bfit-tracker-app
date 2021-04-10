import 'package:bfit_tracker/theme.dart';
import 'package:bfit_tracker/views/onboarding/weight_screen/widgets/onboarding_weight_stack.dart';
import 'package:flutter/material.dart';

class OnboardingWeightScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainTheme.primaryColor,
      body: SafeArea(
        child: OnboardingWeightStack(),
      ),
    );
  }
}
