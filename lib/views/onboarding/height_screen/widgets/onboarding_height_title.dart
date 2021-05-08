import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class OnboardingHeightTitle extends StatelessWidget {
  const OnboardingHeightTitle({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      'About You',
      minFontSize: 32,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      textAlign: TextAlign.center,
    );
  }
}
