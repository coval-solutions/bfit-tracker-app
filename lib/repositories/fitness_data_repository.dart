import 'package:bfit_tracker/blocs/fitness_data/fitness_data_bloc.dart';
import 'package:bfit_tracker/models/fitness_stat.dart';
import 'package:bfit_tracker/utils.dart';
import 'package:health/health.dart';
import 'package:jiffy/jiffy.dart';

class FitnessDataRepository {
  static const List<HealthDataType> HEALTH_DATA_TYPES = [
    HealthDataType.HEART_RATE,
    HealthDataType.STEPS,
    HealthDataType.BLOOD_PRESSURE_SYSTOLIC,
    HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
    HealthDataType.BODY_TEMPERATURE,
    HealthDataType.ACTIVE_ENERGY_BURNED
  ];

  static const List<HealthDataType> HEALTH_DATA_TYPES_REQUIRE_INCREMENTING = [
    HealthDataType.STEPS,
    HealthDataType.ACTIVE_ENERGY_BURNED,
  ];

  static List<DateTime> getDateTimes() {
    List<DateTime> dateTimes = List<DateTime>();
    DateTime dateTime = Jiffy()
        .startOf(Units.DAY)
        .subtract(Duration(days: FitnessDataBloc.numOfDaysInThePast));
    dateTimes.add(dateTime);
    for (int i = 0; i < FitnessDataBloc.numOfDaysInThePast; i++) {
      dateTime = dateTime.add(Duration(days: 1));
      dateTimes.add(dateTime);
    }

    return dateTimes;
  }

  Future<Map<HealthDataType, Map>> retrieve(DateTime startDateTime) async {
    bool isAuthorized = await Health.requestAuthorization();
    if (isAuthorized) {
      bool isPhysicalDevice = await Utils.isPhysicalDevice;
      if (!isPhysicalDevice) {
        return this._getFakeData();
      }

      List<DateTime> dateTimes = getDateTimes();
      Map<HealthDataType, Map<DateTime, FitnessStat>> fitnessData =
          Map<HealthDataType, Map<DateTime, FitnessStat>>();
      for (HealthDataType type in HEALTH_DATA_TYPES) {
        try {
          DateTime startDate = dateTimes.first;
          DateTime endDate = DateTime.now();
          List<HealthDataPoint> healthData =
              await Health.getHealthDataFromType(startDate, endDate, type);

          Map<DateTime, FitnessStat> fitnessDataForTypeAndDate =
              Map<DateTime, FitnessStat>();
          for (DateTime dateTime in dateTimes) {
            int epochStart = dateTime.millisecondsSinceEpoch;
            int epochEnd =
                Jiffy(dateTime).endOf(Units.DAY).millisecondsSinceEpoch;
            List<HealthDataPoint> healthDataPoints = healthData
                .where((element) =>
                    element.dateFrom >= epochStart &&
                    element.dateFrom <= epochEnd)
                .toList();

            if (healthDataPoints.isEmpty) {
              if (type != HealthDataType.STEPS) {
                break;
              }

              // If we have no steps for a certain day
              // lets create a data point and set the
              // value to zero then, instead of
              // having no data point at all
              healthDataPoints.add(HealthDataPoint(
                  0, 'COUNT', epochStart, epochEnd, type.toString(), 'BFIT'));
            }

            double value = 0.0;
            healthDataPoints.forEach((element) {
              if (HEALTH_DATA_TYPES_REQUIRE_INCREMENTING.contains(type)) {
                // We need to be sum this type
                value += element.value;
              } else {
                if (element.value > value) {
                  value = element.value;
                }
              }
            });

            fitnessDataForTypeAndDate.addAll({
              dateTime: FitnessStat(
                  value: double.parse(value.toStringAsFixed(1)),
                  dateTime: dateTime,
                  type: type)
            });
          }

          fitnessData.addAll({type: fitnessDataForTypeAndDate});
        } catch (exception) {
          // TODO: report this to Crashlytics
          print(exception.toString());
        }
      }

      return fitnessData;
    }

    return null;
  }

  Map<HealthDataType, Map> _getFakeData() {
    List<DateTime> dateTimes = getDateTimes();

    Map<HealthDataType, Map> fitnessStats = Map<HealthDataType, Map>();
    for (HealthDataType type in HEALTH_DATA_TYPES) {
      if (type == HealthDataType.BLOOD_PRESSURE_DIASTOLIC) {
        // In order to avoid Blood Pressure appearing twice
        // in the UI
        continue;
      }

      Map<String, FitnessStat> fitnessStatsForDates =
          Map<String, FitnessStat>();
      for (DateTime dateTime in dateTimes) {
        double value = 0.0;
        switch (type) {
          case HealthDataType.STEPS:
            value = Utils.doubleInRange(1500, 25000);
            break;
          case HealthDataType.ACTIVE_ENERGY_BURNED:
            value = Utils.doubleInRange(150, 3250);
            break;
          default:
            value = Utils.doubleInRange(60, 120);
            break;
        }

        fitnessStatsForDates.addAll({
          dateTime.toString(): FitnessStat(
              value: double.parse(value.toStringAsFixed(1)),
              dateTime: dateTime,
              type: type)
        });
      }

      fitnessStats.addAll({type: fitnessStatsForDates});
    }

    return fitnessStats;
  }
}
