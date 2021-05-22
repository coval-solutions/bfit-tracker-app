import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/utils.dart';
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
        OnboardingSubtitle(subtitleText: subtitleText),
      ],
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
      textAlign: TextAlign.center,
      maxLines: 2,
      presetFontSizes: [28, 26],
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: AutoSizeText(
        subtitleText,
        textAlign: TextAlign.center,
        maxLines: 2,
        minFontSize: Utils.isSmallScreen() ? 16 : 18,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
