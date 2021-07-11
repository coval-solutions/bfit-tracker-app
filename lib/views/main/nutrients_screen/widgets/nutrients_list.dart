import 'package:bfit_tracker/controllers/nutrients_controller.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:bfit_tracker/views/main/nutrients_screen/widgets/nutrients_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NutrientsList extends GetView<NutrientsController> {
  final List<Color> colors = [
    mainTheme.primaryColor,
    mainTheme.accentColor,
  ];

  NutrientsList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.nutrients.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        return NutrientsCard(
          nutrientStat: controller.nutrients[index],
          color: this.colors[(index % this.colors.length)],
        );
      },
    );
  }
}
