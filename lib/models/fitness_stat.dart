import 'package:bfit_tracker/enums/fitness_stat_types.dart';
import 'package:bfit_tracker/ui/custom.dart';
import 'package:health/health.dart';

class FitnessStat {
  String value;
  DateTime dateTime;
  HealthDataType type;

  FitnessStat({this.value, this.dateTime, this.type});

  String getHumanReadableValue() {
    switch (this.type) {
      case HealthDataType.HEART_RATE:
        return double.parse(this.value).toStringAsFixed(0);
      case HealthDataType.STEPS:
        return CovalMath.compact(double.parse(this.value));
      default:
        return this.value;
    }
  }

  String getHumanReadableType() {
    return HealthDataExtension.getTitle(this.type);
  }

  String getUnits() {
    return HealthDataExtension.getUnits(this.type);
  }
}
