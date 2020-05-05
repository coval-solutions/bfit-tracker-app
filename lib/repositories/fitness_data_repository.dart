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

  Future<Map<HealthDataType, Map>> retrieve(DateTime startDateTime) async {
    Map<HealthDataType, Map> fitnessStats = Map<HealthDataType, Map>();
    bool isAuthorized = await Health.requestAuthorization();
    if (isAuthorized) {
      bool isPhysicalDevice = await Utils.isPhysicalDevice;
      if (!isPhysicalDevice) {
        return this._getFakeData();
      }

      for (HealthDataType type in HEALTH_DATA_TYPES) {
        try {
          List<HealthDataPoint> healthData = await Health.getHealthDataFromType(
              startDateTime, DateTime.now(), type);

          DateTime currentDateFrom;
          double value = 0.0;
          int count = 0;
          Map<String, FitnessStat> fitnessStatsForDates =
              Map<String, FitnessStat>();
          for (HealthDataPoint healthDataPoint in healthData) {
            DateTime dateFrom =
                Jiffy.unix(healthDataPoint.dateFrom).startOf(Units.DAY);

            // Initalise currentDateFrom (occurs only once)
            if (currentDateFrom == null) {
              currentDateFrom = dateFrom;
            }

            // Ensure the today's (i.e. the last in the list) stats get added too
            if ((currentDateFrom != null &&
                    currentDateFrom.millisecondsSinceEpoch !=
                        dateFrom.millisecondsSinceEpoch) ||
                count == healthData.length - 1) {
              // Add/set the last data point to the value variable
              double finalValue = value + healthDataPoint.value;

              fitnessStatsForDates.addAll({
                currentDateFrom.toString(): FitnessStat(
                    value: double.parse(finalValue.toStringAsFixed(1)),
                    dateTime: currentDateFrom,
                    type: type)
              });

              value = 0.0;
              currentDateFrom = dateFrom;
            }

            switch (healthDataPoint.dataType) {
              case 'STEPS':
                value += healthDataPoint.value;
                break;
              case 'ACTIVE_ENERGY_BURNED':
                value += healthDataPoint.value;
                break;
              default:
                value = healthDataPoint.value;
                break;
            }

            count++;
          }

          fitnessStats.addAll({type: fitnessStatsForDates});
        } catch (exception) {
          // TODO: report this to Crashlytics
          print(exception.toString());
        }
      }
    }

    return fitnessStats;
  }

  Map<HealthDataType, Map> _getFakeData() {
    List<DateTime> dateTimes = List<DateTime>();
    DateTime dateTime = Jiffy().startOf(Units.DAY).subtract(Duration(days: FitnessDataBloc.numOfDaysInThePast));
    dateTimes.add(dateTime);
    for (int i = 0; i < 4; i++) {
      dateTime = dateTime.add(Duration(days: 1));
      dateTimes.add(dateTime);
    }

    Map<HealthDataType, Map> fitnessStats = Map<HealthDataType, Map>();
    for (HealthDataType type in HEALTH_DATA_TYPES) {
      Map<String, FitnessStat> fitnessStatsForDates = Map<String, FitnessStat>();
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
