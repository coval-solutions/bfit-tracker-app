import 'package:bfit_tracker/views/onboarding/height_screen/widgets/onboarding_gender_buttons.dart';
import 'package:bfit_tracker/views/onboarding/height_screen/widgets/onboarding_height_circles.dart';
import 'package:bfit_tracker/views/onboarding/height_screen/widgets/onboarding_height_slider.dart';
import 'package:bfit_tracker/views/onboarding/height_screen/widgets/onboarding_height_title.dart';
import 'package:bfit_tracker/views/onboarding/onboarding_screen.dart';
import 'package:bfit_tracker/views/onboarding/widgets/onboarding_dots_indicator.dart';
import 'package:bfit_tracker/views/onboarding/widgets/onboarding_next_button.dart';
import 'package:flutter/material.dart';

class OnboardingHeightStack extends StatelessWidget {
  const OnboardingHeightStack({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      // alignment: Alignment.topCenter,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 275),
          child: HeightCirclesBackground(),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: OnboardingHeightTitle(),
            ),
            OnboardingGenderButtons(),
            OnboardingHeightSlider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: OnboardingDotsIndicator(
                dotsCount: OnboardingScreenState.NUM_OF_PAGES,
                currentDotPosition: double.parse(
                        OnboardingScreenState.NUM_OF_PAGES.toString()) -
                    1,
              ),
            ),
            OnboardingNextButton(),
          ],
        ),
      ],
    );
  }
}
