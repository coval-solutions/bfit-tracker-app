import 'dart:async';

import 'package:bfit_tracker/app.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Global vars
bool isTesting = false;

Future<void> main({bool testing: false}) async {
  isTesting = testing;

  WidgetsFlutterBinding.ensureInitialized();

  await DotEnv().load('.env');
  await Firebase.initializeApp();

  FirebaseFirestore.instance.settings =
      Settings(persistenceEnabled: kReleaseMode);

  // BlocSupervisor.delegate = SimpleBlocDelegate();
  // final UserRepository userRepository = UserRepository();
  // final ArticleRepository articleRepository = ArticleRepository();
  // final UserInfoRepository userInfoRepository = UserInfoRepository();
  // final LocationRepository locationRepository = LocationRepository();
  // final GymRepository gymRepository = GymRepository();
  // final FitnessDataRepository fitnessDataRepository = FitnessDataRepository();
  // final NutritionDataRepository nutritionDataRepository =
  //     NutritionDataRepository();
  // final WorkoutRepository workoutRepository = WorkoutRepository();

  await FirebaseCrashlytics.instance
      .setCrashlyticsCollectionEnabled(kReleaseMode && !isTesting);

  FirebaseAnalytics().setAnalyticsCollectionEnabled(kReleaseMode && !isTesting);

  runZonedGuarded(() {
    runApp(App());
  }, (error, stackTrace) {
    print('runZonedGuarded: Caught error in my root zone.');
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
  });
}
