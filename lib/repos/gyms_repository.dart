import 'dart:convert';

import 'package:bfit_tracker/internal/keys.dart';
import 'package:bfit_tracker/models/gym.dart';
import 'package:bfit_tracker/repos/location_repository.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';

class GymsRepository {
  static const String API_TYPE_GYM = 'gym';
  static List<Gym> _gyms;

  GymsRepository();

  Future<List<Gym>> getGyms() async {
    Position location = await LocationRepository().getLocation();
    Position fetchedLocation = await LocationRepository().getLocation(force: true);

    // If the location has changed, let's get new data
    if (location.latitude != fetchedLocation.latitude || location.longitude != fetchedLocation.longitude) {
      return await this._fetch(fetchedLocation.latitude, fetchedLocation.longitude);
    }
    
    if (GymsRepository._gyms != null && GymsRepository._gyms.length > 0) {
      return GymsRepository._gyms;
    }

    return await this._fetch(location.latitude, location.longitude);
  }

  Future<List<Gym>> _fetch(double lat, double long) async {
    final response = await get("${LocationRepository.GOOGLE_MAPS_API_URL}location=$lat,$long&radius=2500&types=$API_TYPE_GYM&key=${Keys.GOOGLE_MAPS_KEY}");
    final result = json.decode(response.body)['results'];
    
    GymsRepository._gyms = [];
    result.forEach((gym) => GymsRepository._gyms.add(Gym.fromJson(gym)));

    return GymsRepository._gyms;
  }
}