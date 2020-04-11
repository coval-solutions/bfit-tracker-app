import 'package:health/health.dart';

class Stats {
  static const String HEART_RATE_NAME = 'Heart Rate';
  static const String STEPS_NAME = 'Steps Taken';
  static const String WORKOUTS_COMPLETE_NAME = 'Workouts Complete';
  static const String BLOOD_PRESSURE_NAME = 'Blood Pressure';
  static const String BODY_TEMPERATURE_NAME = 'Body Temperature';
  static const String ACTIVE_ENERGY_BURNED_RATE_NAME = 'Energy Burned';

  static const String HEART_RATE_UNIT = 'bpm';
  static const String STEPS_UNIT = 'steps';
  static const String CELSIUS_UNIT = '°C';
  static const String CALORIES_UNIT = 'cal';

  double steps = 0;
  double heartRate = 0;
  double workoutsComplete = 0;
  double bloodPressureSystolic = 0;
  double bloodPressureDiastolic = 0;
  double bodyTemperature = 0;
  double respiratoryRate = 0;
  double activeEnergyBurned = 0;

  Stats();

  Stats fromSnapshot(List<HealthDataPoint> data) {
    for (HealthDataPoint healthDataPoint in data) {
      switch (healthDataPoint.dataType) {
        case 'HEART_RATE':
          this.heartRate = healthDataPoint.value;
          break;
        case 'STEPS':
          this.steps += healthDataPoint.value;
          break;
        case 'BLOOD_PRESSURE_SYSTOLIC':
          this.bloodPressureSystolic = healthDataPoint.value;
          break;
        case 'BLOOD_PRESSURE_DIASTOLIC':
          this.bloodPressureDiastolic = healthDataPoint.value;
          break;
        case 'BODY_TEMPERATURE':
          this.bodyTemperature = healthDataPoint.value;
          break;
        case 'ACTIVE_ENERGY_BURNED':
          this.activeEnergyBurned = healthDataPoint.value;
          break;
      }
    }

    return this;
  }
}