import 'dart:convert';
import 'dart:io';

import 'package:bfit_tracker/blocs/user_info/user_info_bloc.dart';
import 'package:bfit_tracker/models/exercise.dart';
import 'package:bfit_tracker/models/user_info.dart';
import 'package:bfit_tracker/models/workout.dart';
import 'package:bfit_tracker/repositories/user_repository.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class WorkoutController {
  static String apiUrl =
      '${DotEnv().env['GOOGLE_FUNCTIONS_URL'] ?? 'http://localhost:5001/'}';

  static Future<int> fetchWorkoutStartedCount(String docRef) async {
    String token = await UserRepository.getIdToken();

    final resp = await http.get('$apiUrl/workout-started-count/$docRef',
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

  static Future<UserInfo> workoutCompleted(UserInfoBloc userInfoBloc,
      Workout workout, double secondsWorkingOut) async {
    final Stream<UserInfo> userInfo = userInfoBloc.state.props.first;
    UserInfo userInfoObj = await userInfo.first;

    Map<String, dynamic> workoutsCompleted =
        userInfoObj.workoutsComplete ?? new Map<String, dynamic>();
    for (Exercise exercise in workout.exercises) {
      exercise.type.forEach((element) {
        if (workoutsCompleted.containsKey(element)) {
          workoutsCompleted[element] = workoutsCompleted[element] + 1;
        } else {
          workoutsCompleted[element] = 1;
        }
      });
    }

    UserInfo newUserInfo = new UserInfo(
        height: userInfoObj.height,
        isMale: userInfoObj.isMale,
        gymTime: (userInfoObj.gymTime ?? 0) + secondsWorkingOut / 60,
        goals: userInfoObj.goals,
        workoutsComplete: workoutsCompleted);

    userInfoBloc.add(UpdateUserInfo(newUserInfo));
    return newUserInfo;
  }
}
