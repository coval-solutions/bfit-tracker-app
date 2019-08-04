import 'dart:convert';

import 'package:bfit_tracker/internal/keys.dart';
import 'package:bfit_tracker/models/gym.dart';
import 'package:bfit_tracker/repos/location_repository.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';

class GymController {
  static const String API_TYPE_GYM = 'gym';
  static const String BASE_PLACE_ID_GOOGLE_MAPS_URL = 'https://www.google.com/maps/dir/?api=1&destination=';

  static Future<List<Gym>> getGyms(double lat, double long) async {
    final response = await get("${LocationRepository.GOOGLE_MAPS_API_URL}location=$lat,$long&radius=2500&types=$API_TYPE_GYM&key=${Keys.GOOGLE_MAPS_KEY}");
    
    List<Gym> gyms = List<Gym>();
    
    final result = json.decode(response.body)['results'];
    result.forEach((gym) => gyms.add(Gym.fromJson(gym))); 

    return gyms;
  }

  static launchGoogleMaps(double lat, double lng) async {
    String url = BASE_PLACE_ID_GOOGLE_MAPS_URL + lat.toString() + "," + lng.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}