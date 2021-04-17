import 'package:bfit_tracker/views/onboarding/onboarding_screen.dart';
import 'package:bfit_tracker/views/onboarding/widgets/onboarding_background_circles.dart';
import 'package:bfit_tracker/views/onboarding/widgets/onboarding_dots_indicator.dart';
import 'package:bfit_tracker/views/onboarding/widgets/onboarding_exercise_image.dart';
import 'package:bfit_tracker/views/onboarding/widgets/onboarding_next_button.dart';
import 'package:bfit_tracker/views/onboarding/widgets/onboarding_skip_button.dart';
import 'package:bfit_tracker/views/onboarding/widgets/onboarding_titles.dart';
import 'package:flutter/material.dart';
import 'package:transformer_page_view/transformer_page_view.dart';

class OnboardingStack extends StatelessWidget {
  final String backgroundAssetPath;
  final String mainImageAssetPath;
  final String mainTitleText;
  final String subtitleText;
  final TransformInfo transformInfo;
  final TransformerPageController transformerPageController;

  const OnboardingStack({
    Key key,
    @required this.backgroundAssetPath,
    @required this.mainImageAssetPath,
    @required this.mainTitleText,
    @required this.subtitleText,
    @required this.transformInfo,
    @required this.transformerPageController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        OnboardingBackgroundCircles(
          transformInfo: transformInfo,
          backgroundAssetPath: backgroundAssetPath,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OnboardingExerciseImage(
              transformInfo: transformInfo,
              mainImageAssetPath: mainImageAssetPath,
            ),
            SizedBox(height: 32),
            OnboardingTitles(
              mainTitleText: mainTitleText,
              subtitleText: subtitleText,
              animate: this.transformInfo.index == 0 ? true : false,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: OnboardingDotsIndicator(
                dotsCount: OnboardingScreenState.NUM_OF_PAGES,
                currentDotPosition:
                    double.parse(transformInfo.index.toString()),
              ),
            ),
          ],
        ),
        Positioned.fill(
          bottom: 16,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SkipOnboardingButton(),
                  OnboardingNextButton(
                    transformerPageController: transformerPageController,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
