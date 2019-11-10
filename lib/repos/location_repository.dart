import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

class LocationRepository {
  static const String GOOGLE_MAPS_API_URL = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?";
  static Position location;

  Future<Position> fetch() async {
    Position location =
      await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .catchError(
          (error) => SystemNavigator.pop()
        );

    LocationRepository.location = location;
    return location;
  }

  Position getLocation() {
    return LocationRepository.location;
  }
}