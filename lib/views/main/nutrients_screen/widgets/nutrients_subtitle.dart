import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:flutter/material.dart';

class NutrientsSubtitle extends StatelessWidget {
  const NutrientsSubtitle({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: AutoSizeText(
        'Weekly',
        maxLines: 1,
        minFontSize: 16,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          color: CustomColor.DIM_GRAY,
        ),
      ),
    );
  }
}
