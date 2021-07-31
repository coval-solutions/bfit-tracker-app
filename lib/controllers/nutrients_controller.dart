import 'dart:io';

import 'package:bfit_tracker/models/nutrient_stat.dart';
import 'package:bfit_tracker/repositories/nutrition_data_repository.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:nutrition/nutrition.dart';
import 'package:nutrition/nutrition_enum.dart';

class NutrientsController extends GetxController {
  NutritionDataRepository _nutritionDataRepository = NutritionDataRepository();
  static const int NUM_OF_DAYS_IN_THE_PAST = 7;

  // Nutrients List
  Rx<List<NutrientStat>> _nutrients = new Rx<List<NutrientStat>>(null);
  List<NutrientStat> get nutrients => _nutrients.value;
  set nutrients(List<NutrientStat> value) => this._nutrients.value = value;

  // Nutrients Dialog Input
  Rx<double> _nutrientsInput = new Rx<double>(0.0);
  double get nutrientsInput => _nutrientsInput.value;
  set nutrientsInput(double value) => this._nutrientsInput.value = value;

  @override
  Future<void> onInit() async {
    super.onInit();
    await this.getNutrientStats();
  }

  Future<void> getNutrientStats() async {
    print("getNutrientStats() called.");

    Jiffy startDateTime = Jiffy()..startOf(Units.DAY);
    startDateTime = startDateTime
      ..subtract(duration: Duration(days: NUM_OF_DAYS_IN_THE_PAST));

    Stream<List<NutrientStat>> nutrientsStream = _nutritionDataRepository
        .retrieve(startDateTime.dateTime, DateTime.now())
        .asStream();
    if (nutrientsStream != null) {
      this.nutrients = await nutrientsStream.first;
    }

    return;
  }

  Future<void> addNutrientStat(
      NutritionEnum nutritionEnum, double value) async {
    print("addNutrientStat() called.");

    if (nutritionEnum == NutritionEnum.VITAMIN_A && Platform.isAndroid) {
      // Convert MCG to IU - IU * 3.33
      value *= 3.33;
    }

    // Send the data over to Google Fit/Apple Health
    Nutrition.addData({nutritionEnum: value}, DateTime.now());

    // Manually update it locally, don't re-retrieve the entire data
    List<NutrientStat> nutrientStats = this.nutrients;
    this.nutrients.add(new NutrientStat(
          type: nutritionEnum,
          value: value.toString(),
        ));

    // this.nutrients = nutrientStats;

    // this.onInit();
    return;
  }

  Future<void> refresh() async {
    this.onInit();
    return;
  }
}
