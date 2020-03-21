import 'package:bfit_tracker/blocs/authentication/authentication_bloc.dart';
import 'package:bfit_tracker/models/user.dart';
import 'package:bfit_tracker/models/user_info.dart';
import 'package:bfit_tracker/repositories/user_repository.dart';
import 'package:bfit_tracker/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  final UserRepository _userRepository;

  App(
      {Key key,
      @required UserRepository userRepository})
      : assert(userRepository != null),
        this._userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          print(state.props);
          if (state is Unauthenticated) {
            return Scaffold(
              body: Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is Authenticated) {
            final User user = state.props[0];
            return StreamBuilder<UserInfo>(
              stream: FirestoreService(user).userInfo,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                print(snapshot);
                if (snapshot.connectionState != ConnectionState.active) {
                  return Scaffold(
                    body: Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  print(snapshot.hasData);
                  if (snapshot.hasData) {
                    print(snapshot.data);
                    return Scaffold(
                      body: Align(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    return Scaffold(
                      body: Align(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                }
              },
            );
            // return FutureBuilder<UserInfo>(
            //   future: _userInfoRepository.getUserInfo(),
            //   builder: (context, snapshot) {
            //     if (snapshot.connectionState == ConnectionState.done) {
            //       if (snapshot.data == null) {
            //         return OnboardingScreenOne();
            //       }
            //     }

            //     return HomeScreen(
            //       user: state.currentUser,
            //       location: state.currentLocation,
            //       courses: _courseRepository.courses
            //     );
            //   },
            // );
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
