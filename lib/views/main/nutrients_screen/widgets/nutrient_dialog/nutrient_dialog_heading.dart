import 'package:bfit_tracker/enums/nutrients.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:bfit_tracker/views/coval_solutions/back_arrow.dart';
import 'package:bfit_tracker/views/main/nutrients_screen/widgets/nutrient_dialog/nutrient_dialog_title.dart';
import 'package:flutter/material.dart';
import 'package:nutrition/nutrition_enum.dart';

class NutrientDialogHeading extends StatelessWidget {
  final NutritionEnum nutrientsEnum;

  NutrientDialogHeading(this.nutrientsEnum);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BackArrow(
          color: CustomColor.DIM_GRAY,
        ),
        NutrientDialogTitle(
          text: this.nutrientsEnum.fullName,
        ),
        // Hacky way of keeping the title in the centre
        BackArrow(
          color: Colors.white,
        ),
      ],
    );
  }
}
