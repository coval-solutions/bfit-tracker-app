import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/ui/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:transformer_page_view/transformer_page_view.dart';

class SkipOnboardingButton extends StatelessWidget {
  final TransformerPageView transformerPageView;

  SkipOnboardingButton(this.transformerPageView);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        transformerPageView.controller.move(OnboardingScreenState.NUM_OF_PAGES - 1);
      },
      child: const AutoSizeText(
        'Skip',
        minFontSize: 14,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
