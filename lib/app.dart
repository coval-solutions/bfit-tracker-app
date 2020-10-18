import 'package:bfit_tracker/blocs/authentication/authentication_bloc.dart';
import 'package:bfit_tracker/blocs/user_info/user_info_bloc.dart';
import 'package:bfit_tracker/main.dart';
import 'package:bfit_tracker/models/user_info.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:bfit_tracker/ui/home/home_screen.dart';
import 'package:bfit_tracker/ui/onboarding/onboarding_screen.dart';
import 'package:bfit_tracker/ui/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:health/health.dart';
import 'package:nutrition/nutrition.dart';
import 'package:wiredash/wiredash.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  bool _haveHealthPermission = false;
  bool _haveNutritionPermission = false;

  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _checkHealthPermissions() async {
    if (isTesting) {
      setState(() {
        _haveHealthPermission = true;
      });

      return;
    }

    bool isAuthorized = await Health.requestAuthorization();
    setState(() {
      _haveHealthPermission = isAuthorized;
    });
  }

  Future<void> _checkNutritionPermissions() async {
    if (isTesting) {
      setState(() {
        _haveNutritionPermission = true;
      });

      return;
    }

    bool isAuthorized = await Nutrition.requestPermission();
    setState(() {
      _haveNutritionPermission = isAuthorized;
    });
  }

  @override
  Widget build(BuildContext context) {
    final AuthenticationState authenticatedState =
        BlocProvider.of<AuthenticationBloc>(context).state;
    return Wiredash(
      navigatorKey: this._navigatorKey,
      projectId: DotEnv().env['WIREDASH_PROJECT_ID'] ?? '',
      secret: DotEnv().env['WIREDASH_SECRET_KEY'] ?? '',
      child: MaterialApp(
        navigatorKey: this._navigatorKey,
        theme: mainTheme,
        debugShowCheckedModeBanner: false,
        home: (!(authenticatedState is Authenticated))
            ? SplashScreenLoading()
            : BlocConsumer<UserInfoBloc, UserInfoState>(
                listener: (BuildContext context, UserInfoState state) {
                this._checkHealthPermissions();
                this._checkNutritionPermissions();
              }, builder: (BuildContext context, UserInfoState state) {
                if (state is UserInfoLoaded) {
                  return StreamBuilder(
                    stream: state.props.first,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.none ||
                          snapshot.connectionState == ConnectionState.waiting) {
                        return Stack(
                          children: <Widget>[
                            SplashScreenLoading(),
                            Center(
                              child: CircularProgressIndicator(),
                            ),
                          ],
                        );
                      }

                      if (this._haveHealthPermission) {
                        if (this._haveNutritionPermission) {
                          if (snapshot.hasData && snapshot.data is UserInfo) {
                            return HomeScreen(userInfo: snapshot.data);
                          } else {
                            // No data found, let's onboard the user
                            return OnboardingScreen();
                          }
                        }
                      }

                      return SplashScreenLoading();
                    },
                  );
                } else {
                  return SplashScreenLoading();
                }
              }),
      ),
    );
  }
}
