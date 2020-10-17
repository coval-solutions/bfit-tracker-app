import 'package:geolocator/geolocator.dart';

class LocationRepository {
  Future<Position> retrieve() async {
    try {
      Position location =
          await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      return location;
    } catch (err) {
      // We want to throw the error so that
      // the bloc will deal with the exception
      throw err;
    }
  }
}
