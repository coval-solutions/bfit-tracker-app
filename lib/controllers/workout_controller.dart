import 'dart:convert';
import 'dart:io';

import 'package:bfit_tracker/repositories/user_repository.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class WorkoutController {
  static String API_URL =
      '${DotEnv().env['GOOGLE_FUNCTIONS_URL'] ?? 'http://localhost:5001/'}';

  static Future<int> fetchWorkoutStartedCount(String docRef) async {
    String token = await UserRepository.getIdToken();

    final resp = await http.get('$API_URL/workout-started-count/$docRef',
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
    if (resp.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      Map<String, dynamic> body = json.decode(resp.body);
      if (!body.containsKey('count')) {
        FirebaseCrashlytics.instance.recordError(
            Exception(
                'Failed to load Workout started count, missing `count` key'),
            StackTrace.current,
            reason: resp.statusCode);
        return 0;
      }

      return body['count'];
    } else {
      // If the server did not return a 200 OK response,
      // then return the default value of 0, and report to Crashlytics.
      FirebaseCrashlytics.instance.recordError(
          Exception('Failed to load Workout started count'), StackTrace.current,
          reason: resp.statusCode);
      return 0;
    }
  }
}
