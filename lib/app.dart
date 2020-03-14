import 'package:bfit_tracker/repos/user_repository.dart';
import 'package:bfit_tracker/ui/onboarding/onboarding_screen_one.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/authentication/index.dart';

class App extends StatelessWidget {
  final UserRepository _userRepository;

  App({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Unauthenticated) {
            return Scaffold(
              body: Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (state is Authenticated) {
            return OnboardingScreenOne();
            // return HomeScreen(user: state.currentUser, location: state.currentLocation, courses: _courseRepository.courses);
          }

          return Scaffold(
            body: Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}