import 'package:bfit_tracker/enums/fitness_stat_types.dart';
import 'package:bfit_tracker/ui/custom.dart';
import 'package:health/health.dart';

class FitnessStat {
  final double value;
  final DateTime dateTime;
  final HealthDataType type;

  FitnessStat({this.value, this.dateTime, this.type});

  String getHumanReadableValue() {
    switch (this.type) {
      case HealthDataType.HEART_RATE:
        return this.value.toStringAsFixed(0);
      case HealthDataType.STEPS:
        return CovalMath.compact(this.value);
      default:
        return this.value.toStringAsFixed(1);
    }
  }

  String getHumanReadableType() {
    return HealthDataExtension.getTitle(this.type);
  }

  String getUnits() {
    return HealthDataExtension.getUnits(this.type);
  }
}
