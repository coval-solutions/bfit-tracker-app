import 'dart:convert';

import 'package:bfit_tracker/internal/keys.dart';
import 'package:bfit_tracker/models/gym.dart';
import 'package:bfit_tracker/repos/location_repository.dart';
import 'package:http/http.dart';

class GymController {
  static const String API_TYPE_GYM = "gym";

  static Future<List<Gym>> getGyms(double lat, double long) async{
    final response = await get("${LocationRepository.GOOGLE_MAPS_API_URL}location=$lat,$long&radius=2500&types=$API_TYPE_GYM&key=${Keys.GOOGLE_MAPS_KEY}");
    
    List<Gym> gyms = List<Gym>();
    
    final result = json.decode(response.body)['results'];
    result.forEach((gym) => gyms.add(Gym.fromJson(gym))); 

    return gyms;
  }
}