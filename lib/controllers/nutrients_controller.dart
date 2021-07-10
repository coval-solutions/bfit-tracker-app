import 'package:bfit_tracker/models/nutrient_stat.dart';
import 'package:bfit_tracker/repositories/nutrition_data_repository.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

class NutrientsController extends GetxController {
  NutritionDataRepository _nutritionDataRepository = NutritionDataRepository();
  static const int NUM_OF_DAYS_IN_THE_PAST = 7;

  Rx<List<NutrientStat>> _nutrients = new Rx<List<NutrientStat>>(null);
  List<NutrientStat> get nutrients => _nutrients.value;
  set nutrients(List<NutrientStat> value) => this._nutrients.value = value;

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
        .retrieve(startDateTime.dateTime, DateTime.now()).asStream();
    if (nutrientsStream != null) {
      this.nutrients = await nutrientsStream.first;
    }

    return;
  }

  Future<void> refresh() async {
    this.onInit();
    return;
  }
}
