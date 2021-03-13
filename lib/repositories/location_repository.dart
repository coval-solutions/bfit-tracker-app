import 'package:bfit_tracker/main.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jiffy/jiffy.dart';

class LocationRepository {
  Future<Position> retrieve() async {
    if (isTesting) {
      return Position(
        // Coval Solutions HQ
        latitude: 51.459944,
        longitude: -0.106652,
        altitude: 0,
        speed: 0,
        speedAccuracy: 1,
        accuracy: 1,
        timestamp: Jiffy().dateTime,
        heading: 0,
      );
    }

    try {
      Position location = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      return location;
    } catch (err, stack) {
      // We want to throw the error so that
      // the bloc will deal with the exception
      FirebaseCrashlytics.instance.recordError(err, stack);
      throw err;
    }
  }
}
