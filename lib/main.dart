import 'package:bfit_tracker/app.dart';
import 'package:bfit_tracker/blocs/authentication/authentication_bloc.dart';
import 'package:bfit_tracker/blocs/fitness_data/fitness_data_bloc.dart';
import 'package:bfit_tracker/blocs/gym/gym_bloc.dart';
import 'package:bfit_tracker/blocs/location/location_bloc.dart';
import 'package:bfit_tracker/blocs/user_info/user_info_bloc.dart';
import 'package:bfit_tracker/repositories/fitness_data_repository.dart';
import 'package:bfit_tracker/repositories/gym_repository.dart';
import 'package:bfit_tracker/repositories/location_repository.dart';
import 'package:bfit_tracker/repositories/user_info_repository.dart';
import 'package:bfit_tracker/repositories/user_repository.dart';
import 'package:bfit_tracker/simple_bloc_delegate.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await DotEnv().load('.env');
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final UserRepository userRepository = UserRepository();
  final UserInfoRepository userInfoRepository = UserInfoRepository();
  final LocationRepository locationRepository = LocationRepository();
  final GymRepository gymRepository = GymRepository();
  final FitnessDataRepository fitnessDataRepository = FitnessDataRepository();
  final DateTime now = DateTime.now();

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
          )..add(LoadFitnessData(DateTime.utc(now.year, now.month, now.day))),
        ),
      ],
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
        return App();
      }),
    ),
  );
}
