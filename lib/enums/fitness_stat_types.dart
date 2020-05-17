import 'package:health/health.dart';

class HealthDataExtension {
  static String getTitle(HealthDataType healthDataType) {
    switch (healthDataType) {
      case HealthDataType.HEART_RATE:
        return 'Heart\nRate';
      case HealthDataType.STEPS:
        return 'Steps';
      case HealthDataType.BLOOD_PRESSURE_SYSTOLIC:
        return 'Blood Pressure';
      case HealthDataType.BLOOD_PRESSURE_DIASTOLIC:
        return 'Blood Pressure';
      case HealthDataType.BODY_TEMPERATURE:
        return 'Body Temperature';
      case HealthDataType.ACTIVE_ENERGY_BURNED:
        return 'Energy Burned';
      default:
        return '';
    }
  }

  static String getUnits(HealthDataType healthDataType) {
    switch (healthDataType) {
      case HealthDataType.HEART_RATE:
        return 'bpm';
      case HealthDataType.STEPS:
        return 'steps';
      case HealthDataType.BODY_TEMPERATURE:
        return '°C';
      case HealthDataType.ACTIVE_ENERGY_BURNED:
        return 'cal';
      default:
        return '';
    }
  }
}
