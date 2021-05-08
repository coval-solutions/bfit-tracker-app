import 'package:bfit_tracker/utils.dart';
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
    var isSmallScreen = Utils.isSmallScreen();
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(top: isSmallScreen ? 100 : 275),
          child: HeightCirclesBackground(),
        ),
        Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: isSmallScreen ? 4 : 16),
              child: OnboardingHeightTitle(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: isSmallScreen ? 4 : 16),
              child: OnboardingGenderButtons(),
            ),
            OnboardingHeightSlider(),
            Spacer(),
          ],
        ),
        Positioned.fill(
          bottom: 16,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
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
          ),
        ),
      ],
    );
  }
}
