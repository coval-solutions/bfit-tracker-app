import 'package:bfit_tracker/models/user_info.dart';
import 'package:bfit_tracker/repos/course_repository.dart';
import 'package:bfit_tracker/repos/user_info_repository.dart';
import 'package:bfit_tracker/repos/user_repository.dart';
import 'package:bfit_tracker/ui/home/index.dart';
import 'package:bfit_tracker/ui/onboarding/onboarding_screen_one.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/authentication/index.dart';

class App extends StatelessWidget {
  final UserRepository _userRepository;
  final UserInfoRepository _userInfoRepository;
  final CourseRepository _courseRepository;

  App(
      {Key key,
      @required UserRepository userRepository,
      @required UserInfoRepository userInfoRepository,
      @required CourseRepository courseRepository})
      : assert(userRepository != null &&
            userInfoRepository != null &&
            courseRepository != null),
        _userRepository = userRepository,
        _userInfoRepository = userInfoRepository,
        _courseRepository = courseRepository,
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
          } else if (state is Authenticated) {
            return FutureBuilder<UserInfo>(
              future: _userInfoRepository.getUserInfo(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data == null) {
                    return OnboardingScreenOne();
                  }
                }

                return HomeScreen(
                  user: state.currentUser,
                  location: state.currentLocation,
                  courses: _courseRepository.courses
                );
              },
            );
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
