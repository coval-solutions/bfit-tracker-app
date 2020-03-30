import 'package:bfit_tracker/blocs/authentication/authentication_bloc.dart';
import 'package:bfit_tracker/blocs/user_info/user_info_bloc.dart';
import 'package:bfit_tracker/models/user_info.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:bfit_tracker/ui/home/home_screen.dart';
import 'package:bfit_tracker/ui/onboarding/onboarding_screen.dart';
import 'package:bfit_tracker/ui/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthenticationState authenticatedState =
        BlocProvider.of<AuthenticationBloc>(context).state;
    return MaterialApp(
      theme: mainTheme,
      debugShowCheckedModeBanner: false,
      home: (!(authenticatedState is Authenticated))
          ? SplashScreenLoading()
          : BlocBuilder<UserInfoBloc, UserInfoState>(
              builder: (BuildContext context, UserInfoState state) {
              print(state);
              if (state is UserInfoLoaded) {
                return StreamBuilder(
                  stream: state.props.first,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData && snapshot.data is UserInfo) {
                      return HomeScreen();
                    } else {
                      // No data found, let's onboard the user
                      return OnboardingScreen();
                    }
                  },
                );
              } else {
                return SplashScreenLoading();
              }
            }),
    );
  }
}
