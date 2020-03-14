import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:bfit_tracker/ui/custom.dart';
import 'package:flutter/material.dart';
import 'package:height_slider/height_slider.dart';
import 'package:weight_slider/weight_slider.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int height = 170;
  int weight = 80;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EmptyAppBar(),
      backgroundColor: mainTheme.backgroundColor,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: AutoSizeText(
                'About You',
                maxLines: 1,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: CustomColor.DIM_GRAY,
                  fontSize: 32,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: HeightSlider(
                height: this.height,
                onChange: (val) => setState(() => this.height = val),
                personImagePath: 'assets/images/onboarding/man.svg',
              ),
            ),
            Expanded(
              child: WeightSlider(
                weight: this.weight,
                onChange: (val) => setState(() => this.weight = val),
              ),
            ),
          ],
        ),
      ),
    );
  }
}