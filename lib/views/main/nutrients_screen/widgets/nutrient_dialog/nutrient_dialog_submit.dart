import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/controllers/nutrients_controller.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutrition/nutrition_enum.dart';

class NutrientDialogSubmit extends GetView<NutrientsController> {
  final NutritionEnum nutrientsEnum;

  NutrientDialogSubmit(this.nutrientsEnum);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      color: mainTheme.buttonColor,
      onPressed: () {
        print(controller.nutrientsInput);
        controller.addNutrientStat(this.nutrientsEnum, controller.nutrientsInput);
        Navigator.of(context).pop();
      },
      child: AutoSizeText(
        'Confirm',
        maxLines: 1,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
        minFontSize: 20,
      ),
    );
  }
}
