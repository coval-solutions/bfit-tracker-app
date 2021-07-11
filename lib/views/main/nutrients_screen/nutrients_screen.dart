import 'package:bfit_tracker/controllers/nutrients_controller.dart';
import 'package:bfit_tracker/views/main/nutrients_screen/widgets/nutrients_list.dart';
import 'package:bfit_tracker/views/main/nutrients_screen/widgets/nutrients_subtitle.dart';
import 'package:bfit_tracker/views/main/nutrients_screen/widgets/nutrients_title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NutrientsScreen extends GetView<NutrientsController> {
  const NutrientsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: controller.onInit,
      child: SingleChildScrollView(
        child: Column(
          children: [
            NutrientsTitle(),
            NutrientsSubtitle(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Obx(() =>
                  controller.nutrients == null || controller.nutrients.isEmpty
                      ? CircularProgressIndicator()
                      : NutrientsList()),
            ),
          ],
        ),
      ),
    );
  }
}
