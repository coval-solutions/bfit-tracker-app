import 'package:bfit_tracker/views/onboarding/weight_screen/widgets/onboarding_weight_circles.dart';
import 'package:flutter/material.dart';

class OnboardingWeightStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 275),
          child: WeightCirclesBackground(),
        ),
      ],
    );
  }
}
