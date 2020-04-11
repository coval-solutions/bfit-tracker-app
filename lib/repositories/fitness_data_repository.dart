import 'package:bfit_tracker/models/stats.dart';
import 'package:health/health.dart';

class FitnessDataRepository {
  static const List<HealthDataType> HEALTH_DATA_TYPES = [
    HealthDataType.HEART_RATE,
    HealthDataType.STEPS,
    HealthDataType.BLOOD_PRESSURE_SYSTOLIC,
    HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
    HealthDataType.BODY_TEMPERATURE,
    HealthDataType.ACTIVE_ENERGY_BURNED
  ];

  Future<Stats> retrieve(DateTime startDateTime) async {
    bool isAuthorized = await Health.requestAuthorization();
    if (isAuthorized) {
      DateTime startDate = DateTime.utc(startDateTime.year, startDateTime.month, startDateTime.day);
      DateTime endDate = DateTime.utc(startDate.year, startDate.month, startDate.day, 23, 59, 59);
      List<HealthDataPoint> healthDataList = List<HealthDataPoint>();
      for (HealthDataType type in HEALTH_DATA_TYPES) {
        try {
          List<HealthDataPoint> healthData =
              await Health.getHealthDataFromType(startDate, endDate, type);
          healthDataList.addAll(healthData);
        } catch (exception) {
          // TODO: report this to Crashlytics
          print(exception.toString());
        }
      }

      return Stats().fromSnapshot(healthDataList);
    }

    return null;
  }
}
