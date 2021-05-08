import 'package:bfit_tracker/theme.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class OnboardingDotsIndicator extends StatefulWidget {
  final int dotsCount;
  final double currentDotPosition;
  final Color color;

  OnboardingDotsIndicator({
    this.dotsCount = 1,
    this.currentDotPosition = 0,
    this.color = CustomColor.SELECTIVE_YELLOW,
  });

  @override
  _OnboardingDotsIndicatorState createState() =>
      _OnboardingDotsIndicatorState();
}

class _OnboardingDotsIndicatorState extends State<OnboardingDotsIndicator> {
  @override
  Widget build(BuildContext context) {
    return DotsIndicator(
      dotsCount: widget.dotsCount,
      position: widget.currentDotPosition,
      decorator: DotsDecorator(
        spacing: EdgeInsets.only(right: 3),
        shape: CircleBorder(
            side: BorderSide(
          color: Colors.white,
        )),
        color: widget.color,
        activeColor: Colors.white,
      ),
    );
  }
}
