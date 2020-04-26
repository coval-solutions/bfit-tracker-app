import 'package:bfit_tracker/enums/fitness_stat_types.dart';
import 'package:health/health.dart';

class FitnessStat {
  final double value;
  final DateTime dateTime;
  final HealthDataType type;

  FitnessStat({this.value, this.dateTime, this.type});

  String getHumanReadableType() {
    return HealthDataExtension.getTitle(this.type);
  }

  String getUnits() {
    return HealthDataExtension.getUnits(this.type);
  }
}
