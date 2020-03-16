import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/ui/home/index.dart';
import 'package:flutter/material.dart';

class SkipOnboardingButton extends StatelessWidget {
  const SkipOnboardingButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => HomeScreen()));
        }
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
