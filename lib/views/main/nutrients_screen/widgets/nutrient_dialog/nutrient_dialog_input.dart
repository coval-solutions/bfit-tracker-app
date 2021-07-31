import 'package:bfit_tracker/controllers/nutrients_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NutrientDialogInput extends GetView<NutrientsController> {
  final String text;

  NutrientDialogInput(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      child: TextField(
        onChanged: (text) => controller.nutrientsInput = double.parse(text),
        maxLines: 1,
        maxLength: 3,
        autofocus: true,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintMaxLines: 1,
          hintText: "Enter value (${this.text})",
        ),
      ),
    );
  }
}
