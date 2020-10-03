import 'dart:async';

import 'package:bfit_tracker/app.dart';
import 'package:bfit_tracker/blocs/authentication/authentication_bloc.dart';
import 'package:bfit_tracker/blocs/fitness_data/fitness_data_bloc.dart';
import 'package:bfit_tracker/blocs/gym/gym_bloc.dart';
import 'package:bfit_tracker/blocs/location/location_bloc.dart';
import 'package:bfit_tracker/blocs/nutrition_data/nutrition_data_bloc.dart';
import 'package:bfit_tracker/blocs/user_info/user_info_bloc.dart';
import 'package:bfit_tracker/blocs/workout/workout_bloc.dart';
import 'package:bfit_tracker/repositories/exercise_repository.dart';
import 'package:bfit_tracker/repositories/fitness_data_repository.dart';
import 'package:bfit_tracker/repositories/gym_repository.dart';
import 'package:bfit_tracker/repositories/location_repository.dart';
import 'package:bfit_tracker/repositories/nutrition_data_repository.dart';
import 'package:bfit_tracker/repositories/user_info_repository.dart';
import 'package:bfit_tracker/repositories/user_repository.dart';
import 'package:bfit_tracker/repositories/workout_repository.dart';
import 'package:bfit_tracker/simple_bloc_delegate.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DotEnv().load('.env');
  await Firebase.initializeApp();

  BlocSupervisor.delegate = SimpleBlocDelegate();
  final UserRepository userRepository = UserRepository();
  final UserInfoRepository userInfoRepository = UserInfoRepository();
  final LocationRepository locationRepository = LocationRepository();
  final GymRepository gymRepository = GymRepository();
  final FitnessDataRepository fitnessDataRepository = FitnessDataRepository();
  final NutritionDataRepository nutritionDataRepository =
      NutritionDataRepository();
  final WorkoutRepository workoutRepository = WorkoutRepository();
  final ExerciseRepository exerciseRepository = ExerciseRepository();

  await FirebaseCrashlytics.instance
      .setCrashlyticsCollectionEnabled(kReleaseMode);

  FirebaseAnalytics().setAnalyticsCollectionEnabled(kReleaseMode);

  runZonedGuarded(() {
    runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (BuildContext context) => AuthenticationBloc(
              userRepository: userRepository,
            )..add(AppStarted()),
          ),
          BlocProvider<UserInfoBloc>(
            create: (BuildContext context) => UserInfoBloc(
              user: context.bloc<AuthenticationBloc>().state.props.first,
              userInfoRepository: userInfoRepository,
            )..add(LoadUserInfo()),
          ),
          BlocProvider<LocationBloc>(
              create: (BuildContext context) => LocationBloc(
                    locationRepository: locationRepository,
                  )..add(Requested())),
          BlocProvider<GymBloc>(
            create: (BuildContext context) => GymBloc(
              position: context.bloc<LocationBloc>().state.props.first,
              gymRepository: gymRepository,
            )..add(LoadGym()),
          ),
          BlocProvider<FitnessDataBloc>(
            create: (BuildContext context) => FitnessDataBloc(
              fitnessDataRepository: fitnessDataRepository,
            )..add(LoadFitnessData()),
          ),
          BlocProvider<NutritionDataBloc>(
            create: (BuildContext context) => NutritionDataBloc(
              nutritionDataRepository: nutritionDataRepository,
            )..add(LoadNutritionData()),
          ),
          BlocProvider<WorkoutBloc>(
            create: (BuildContext context) => WorkoutBloc(
                workoutRepository: workoutRepository,
                exerciseRepository: exerciseRepository)
              ..add(LoadWorkouts()),
          ),
        ],
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
          return App();
        }),
      ),
    );
  }, (error, stackTrace) {
    print('runZonedGuarded: Caught error in my root zone.');
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
  });
}
