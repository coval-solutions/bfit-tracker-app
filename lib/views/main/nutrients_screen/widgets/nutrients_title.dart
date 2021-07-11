import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:flutter/material.dart';

class NutrientsTitle extends StatelessWidget {
  const NutrientsTitle({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: AutoSizeText(
        'Nutritions Tracker',
        maxLines: 1,
        minFontSize: 28,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: CustomColor.DIM_GRAY,
        ),
      )
    );
  }
}
