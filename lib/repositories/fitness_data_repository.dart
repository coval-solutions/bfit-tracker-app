import 'package:health/health.dart';

class FitnessDataRepository {
  static const List<HealthDataType> HEALTH_DATA_TYPES = [
    HealthDataType.WEIGHT,
    HealthDataType.HEIGHT,
    HealthDataType.STEPS,
  ];

  Future<List<HealthDataPoint>> retrieve() async {
    bool isAuthorized = await Health.requestAuthorization();
    if (isAuthorized) {
      DateTime now = DateTime.now();
      DateTime yesterday = now.subtract(Duration(days: 1));
      DateTime startDate = DateTime.utc(yesterday.year, yesterday.month, yesterday.day);
      List<HealthDataPoint> healthDataList = List<HealthDataPoint>();
      for (HealthDataType type in HEALTH_DATA_TYPES) {
        try {
          List<HealthDataPoint> healthData =
              await Health.getHealthDataFromType(startDate, now, type);
          healthDataList.addAll(healthData);
        } catch (exception) {
          // TODO: report this to Crashlytics
          print(exception.toString());
        }
      }

      print('LIST: ');
      print(healthDataList);
      return healthDataList;
    }

    return null;
  }
}
