import 'package:bfit_tracker/app.dart';
import 'package:bfit_tracker/blocs/authentication/authentication_bloc.dart';
import 'package:bfit_tracker/blocs/authentication/index.dart';
import 'package:bfit_tracker/repos/location_repository.dart';
import 'package:bfit_tracker/repos/user_repository.dart';
import 'package:bfit_tracker/simple_bloc_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final UserRepository userRepository = UserRepository();
  final LocationRepository locationRepository = LocationRepository();
  
  runApp(
    BlocProvider(
      create: (context) => AuthenticationBloc(userRepository: userRepository, locationRepository: locationRepository)
        ..add(AppStarted()),
      child: App(userRepository: userRepository),
    ),
  );
}
