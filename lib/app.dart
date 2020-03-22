import 'package:bfit_tracker/blocs/authentication/authentication_bloc.dart';
import 'package:bfit_tracker/blocs/user_info/user_info_bloc.dart';
import 'package:bfit_tracker/models/user_info.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:bfit_tracker/ui/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthenticationState authenticatedState = BlocProvider.of<AuthenticationBloc>(context).state;
    if (!(authenticatedState is Authenticated)) {
      return splashScreenLoading();
    } else {
      final UserInfoState userInfoState = BlocProvider.of<UserInfoBloc>(context).state;
      return StreamBuilder(
        stream: userInfoState.props.first,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData && snapshot.data is UserInfo) {
            return splashScreenLoading();
          } else {
            return splashScreenLoading();
          }
        },
      );
    }
  }

  Widget splashScreenLoading() {
    return MaterialApp(
      theme: mainTheme,
      debugShowCheckedModeBanner: false,
      home: SplashScreenLoading(),
    );
  }
}
