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

  double heartRate = 0;
  double steps = 0;
  double workoutsComplete = 0;
  double bloodPressureSystolic = 0;
  double bloodPressureDiastolic = 0;
  double bodyTemperature = 0;
  double activeEnergyBurned = 0;

  Stats();

  Stats fromSnapshot(List<HealthDataPoint> data) {
    for (HealthDataPoint healthDataPoint in data) {
      switch (healthDataPoint.dataType) {
        case 'STEPS':
          this.steps += healthDataPoint.value;
          break;
        case 'HEART_RATE':
          this.heartRate = healthDataPoint.value;
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

  List<Map<Map<String, String>, String>> toArray() {
    List<Map<Map<String, String>, String>> array = new List();
    if (this.heartRate > 0) {
      Map<String, String> nameAndUnitMap = { HEART_RATE_NAME: HEART_RATE_UNIT };
      Map<Map<String, String>, String> nameUnitAndValueMap = { nameAndUnitMap: this.heartRate.toString() };
      array.add(nameUnitAndValueMap);
    }

    if (this.steps > 0) {
      Map<String, String> nameAndUnitMap = { STEPS_NAME: STEPS_UNIT };
      Map<Map<String, String>, String> nameUnitAndValueMap = { nameAndUnitMap: this.steps.toString() };
      array.add(nameUnitAndValueMap);
    }

    if (this.workoutsComplete > 0) {
      Map<String, String> nameAndUnitMap = { WORKOUTS_COMPLETE_NAME: '' };
      Map<Map<String, String>, String> nameUnitAndValueMap = { nameAndUnitMap: this.workoutsComplete.toString() };
      array.add(nameUnitAndValueMap);
    }

    if (this.bloodPressureSystolic > 0 && bloodPressureDiastolic > 0) {
      Map<String, String> nameAndUnitMap = { BLOOD_PRESSURE_NAME: '' };
      Map<Map<String, String>, String> nameUnitAndValueMap = { nameAndUnitMap: "${bloodPressureSystolic.toInt()}/${bloodPressureDiastolic.toInt()}" };
      array.add(nameUnitAndValueMap);
    }

    if (this.bodyTemperature > 0) {
      Map<String, String> nameAndUnitMap = { BODY_TEMPERATURE_NAME: CELSIUS_UNIT };
      Map<Map<String, String>, String> nameUnitAndValueMap = { nameAndUnitMap: this.bodyTemperature.toString() };
      array.add(nameUnitAndValueMap);
    }

    // We wanna always display activeEnergyBurned
    Map<String, String> nameAndUnitMap = { ACTIVE_ENERGY_BURNED_RATE_NAME: CALORIES_UNIT };
    Map<Map<String, String>, String> nameUnitAndValueMap = { nameAndUnitMap: this.activeEnergyBurned.toStringAsFixed(1) };
    array.add(nameUnitAndValueMap);

    return array;
    
  }
}