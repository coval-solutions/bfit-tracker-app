import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

class LocationRepository {
  static const String GOOGLE_MAPS_API_URL = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?";
  static Position location;

  Future<Position> _fetch() async {
    Position location =
      await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .catchError(
          (error) => SystemNavigator.pop()
        );

    LocationRepository.location = location;
    return location;
  }

  Future<Position> getLocation({bool force = false}) async {
    if (force) {
      await this._fetch();
    }

    return LocationRepository.location;
  }
}