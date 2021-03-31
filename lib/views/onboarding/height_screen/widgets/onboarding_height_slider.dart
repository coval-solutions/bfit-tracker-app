import 'package:flutter/material.dart';
import 'package:height_slider/height_slider.dart';

class OnboardingHeightSlider extends StatefulWidget {
  @override
  _OnboardingHeightSliderState createState() => _OnboardingHeightSliderState();
}

class _OnboardingHeightSliderState extends State<OnboardingHeightSlider> {
  int height = 170;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: HeightSlider(
        height: height,
        onChange: (val) => setState(() => height = val),
        unit: 'cm',
      ),
    );
  }
}
