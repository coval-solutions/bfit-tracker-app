import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:flutter/material.dart';

class NutrientDialogTitle extends StatelessWidget {
  final String text;

  const NutrientDialogTitle({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      this.text,
      style: TextStyle(
        color: CustomColor.DIM_GRAY,
        fontWeight: FontWeight.bold,
      ),
      minFontSize: 20,
      maxFontSize: 32,
    );
  }
}
