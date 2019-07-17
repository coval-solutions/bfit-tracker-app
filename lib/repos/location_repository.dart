import 'package:geolocator/geolocator.dart';

class LocationRepository {
  static const String GOOGLE_MAPS_API_URL = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?";
  Position _location;

  Future<Position> getCurrentLocation() async {
    _location = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    
    return _location;
  }
}