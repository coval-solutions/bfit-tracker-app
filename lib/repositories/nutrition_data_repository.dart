import 'dart:io';

import 'package:bfit_tracker/enums/nutrients.dart';
import 'package:bfit_tracker/models/nutrient_stat.dart';
import 'package:bfit_tracker/utils.dart';
import 'package:bfit_tracker/utils/coval_math.dart';
import 'package:nutrition/nutrition.dart';
import 'package:nutrition/nutrition_enum.dart';

class NutritionDataRepository {
  Future<List<NutrientStat>> retrieve(
      DateTime startDateTime, DateTime endDateTime) async {
    Map nutrientsEnumMap = NutrientsEnumExtension.map();
    List<NutrientStat> nutrientsStat = List<NutrientStat>();
    bool hasPermission = await Nutrition.requestPermission();
    if (hasPermission) {
      bool isPhysicalDevice = await Utils.isPhysicalDevice;
      if (!isPhysicalDevice) {
        return _getFakeData(random: true);
      }

      List nutritionData = await Nutrition.getData(startDateTime, endDateTime);
      if (nutritionData == null || nutritionData.isEmpty) {
        return _getFakeData(random: false);
      }

      nutrientsEnumMap.forEach((key, value) {
        double sum = 0;
        nutritionData.forEach((element) {
          Map<String, String> map = Map<String, String>.from(element);
          var nutrient =
              map.entries.firstWhere((element) => element.key == key);

          double value = double.parse(nutrient.value);
          if (nutrient.key == Nutrition.dataTypes[NutritionEnum.VITAMIN_A] &&
              Platform.isAndroid) {
            // Convert IU to MCG - IU / 3.33
            value = double.parse((value / 3.33).toStringAsFixed(1));
          }

          sum += value;
        });

        nutrientsStat.add(NutrientStat(
          value: sum.toString(),
          type: value,
        ));
      });

      return nutrientsStat;
    }

    return _getFakeData(random: false);
  }

  List<NutrientStat> _getFakeData({bool random = false}) {
    Map nutrientsEnumMap = NutrientsEnumExtension.map();
    List<NutrientStat> nutrientsStat = List<NutrientStat>();

    nutrientsEnumMap.forEach((key, value) {
      nutrientsStat.add(NutrientStat(
        value:
            random ? CovalMath.doubleInRange(50, 2500).toInt().toString() : '0',
        type: value,
      ));
    });

    return nutrientsStat;
  }
}
