import 'package:bfit_tracker/utils.dart';
import 'package:bfit_tracker/views/onboarding/weight_screen/widgets/onboarding_weight_circles.dart';
import 'package:bfit_tracker/views/onboarding/weight_screen/widgets/onboarding_weight_person.dart';
import 'package:bfit_tracker/views/onboarding/weight_screen/widgets/onboarding_weight_slider.dart';
import 'package:bfit_tracker/views/onboarding/widgets/onboarding_finish_button.dart';
import 'package:flutter/material.dart';

class OnboardingWeightStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var isSmallScreen = Utils.isSmallScreen();
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Padding(
          padding: EdgeInsets.only(top: isSmallScreen ? 100 : 275),
          child: WeightCirclesBackground(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 32.0),
          child: OnboardingWeightPerson(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OnboardingWeightSlider(),
              OnboardingFinishButton(),
            ],
          ),
        ),
      ],
    );
  }
}
