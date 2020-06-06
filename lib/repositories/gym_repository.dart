import 'dart:convert';

import 'package:bfit_tracker/models/gym.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';

class GymRepository {
  static const String GOOGLE_MAPS_API_URL =
      "https://maps.googleapis.com/maps/api/place/nearbysearch/json?";

  Future<List<Gym>> retrieve(Position position) async {
    String url =
        "${GOOGLE_MAPS_API_URL}location=${position.latitude},${position.longitude}&radius=2500&types=gym&key=${DotEnv().env['GOOGLE_MAPS_KEY']}";
    final response = await get(url);
    final result = json.decode(response.body)['results'];

    List<Gym> gyms = List<Gym>();
    result.forEach((gym) => gyms.add(Gym.fromJson(gym)));

    return gyms;
  }
}
