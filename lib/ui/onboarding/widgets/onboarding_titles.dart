import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/ui/onboarding/widgets/onboarding_animated_title.dart';
import 'package:flutter/material.dart';

class OnboardingTitles extends StatelessWidget {
  const OnboardingTitles({
    Key key,
    @required this.mainTitleText,
    @required this.subtitleText,
  }) : super(key: key);

  final String mainTitleText;
  final String subtitleText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 36),
          child: OnboardingAnimatedTitle(text: mainTitleText),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: AutoSizeText(
            subtitleText,
            minFontSize: 16,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
