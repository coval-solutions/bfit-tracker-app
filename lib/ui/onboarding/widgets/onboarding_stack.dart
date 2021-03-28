import 'package:bfit_tracker/ui/onboarding/onboarding_screen.dart';
import 'package:bfit_tracker/ui/onboarding/widgets/onboarding_background_circles.dart';
import 'package:bfit_tracker/ui/onboarding/widgets/onboarding_dots_indicator.dart';
import 'package:bfit_tracker/ui/onboarding/widgets/onboarding_exercise_image.dart';
import 'package:bfit_tracker/ui/onboarding/widgets/onboarding_next_button.dart';
import 'package:bfit_tracker/ui/onboarding/widgets/onboarding_skip_button.dart';
import 'package:bfit_tracker/ui/onboarding/widgets/onboarding_titles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transformer_page_view/transformer_page_view.dart';

class OnboardingStack extends StatelessWidget {
  final String backgroundAssetPath;
  final String mainImageAssetPath;
  final String mainTitleText;
  final String subtitleText;
  final TransformInfo transformInfo;

  const OnboardingStack({
    Key key,
    @required this.backgroundAssetPath,
    @required this.mainImageAssetPath,
    @required this.mainTitleText,
    @required this.subtitleText,
    @required this.transformInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        OnboardingBackgroundCircles(
          transformInfo: transformInfo,
          backgroundAssetPath: backgroundAssetPath,
        ),
        Padding(
          padding: EdgeInsets.only(top: 164),
          child: Align(
            alignment: Alignment.topCenter,
            child: OnboardingExerciseImage(
              transformInfo: transformInfo,
              mainImageAssetPath: mainImageAssetPath,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: (Get.height / 2) + 32,
          ),
          child: OnboardingTitles(
            mainTitleText: mainTitleText,
            subtitleText: subtitleText,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 40, right: 40, left: 40),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OnboardingDotsIndicator(
                  dotsCount: OnboardingScreenState.NUM_OF_PAGES,
                  currentDotPosition:
                      double.parse(transformInfo.index.toString()),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkipOnboardingButton(),
                      OnboardingNextButton(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
