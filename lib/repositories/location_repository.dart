import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

class LocationRepository {
  Future<Position> retrieve() async {
    Position location =
      await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .catchError(
          (error) => SystemNavigator.pop()
        );

    return location;
  }
}