import 'package:bfit_tracker/blocs/authentication/index.dart';
import 'package:bfit_tracker/repos/course_repository.dart';
import 'package:bfit_tracker/repos/location_repository.dart';
import 'package:bfit_tracker/repos/user_repository.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:bfit_tracker/ui/home/index.dart';
import 'package:bfit_tracker/ui/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatefulWidget {
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final UserRepository _userRepository = UserRepository();
  final LocationRepository _locationRepository = LocationRepository();
  final CourseRepository _courseRepository = CourseRepository();
  AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    super.initState();
    _authenticationBloc = AuthenticationBloc(userRepository: _userRepository, locationRepository: _locationRepository);
    _authenticationBloc.dispatch(AppStarted());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: _authenticationBloc,
      child: MaterialApp(
        theme: mainTheme,
        home: BlocBuilder(
          bloc: _authenticationBloc,
          builder: (BuildContext context, AuthenticationState state) {
            print(state);
            if (state is Unauthenticated) {
              _authenticationBloc.dispatch(AppStarted());
              return SplashScreen();
            }

            if (state is Authenticated) {
              return HomeScreen(user: state.currentUser, location: state.currentLocation, courses: _courseRepository.courses);
            }

            return SplashScreen();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _authenticationBloc.dispose();
    super.dispose();
  }
}