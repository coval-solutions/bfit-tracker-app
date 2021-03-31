import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/views/onboarding/widgets/onboarding_animated_title.dart';
import 'package:flutter/material.dart';

class OnboardingTitles extends StatelessWidget {
  final String mainTitleText;
  final String subtitleText;
  final bool animate;

  const OnboardingTitles({
    Key key,
    @required this.mainTitleText,
    @required this.subtitleText,
    this.animate = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 36),
          child: this.animate
              ? OnboardingAnimatedTitle(text: mainTitleText)
              : OnboardingTitle(mainTitleText: mainTitleText),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: OnboardingSubtitle(subtitleText: subtitleText),
        ),
      ],
    );
  }
}

class OnboardingSubtitle extends StatelessWidget {
  const OnboardingSubtitle({
    Key key,
    @required this.subtitleText,
  }) : super(key: key);

  final String subtitleText;

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      subtitleText,
      minFontSize: 16,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class OnboardingTitle extends StatelessWidget {
  const OnboardingTitle({
    Key key,
    @required this.mainTitleText,
  }) : super(key: key);

  final String mainTitleText;

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      mainTitleText,
      minFontSize: 24,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
