import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/blocs/user_info/user_info_bloc.dart';
import 'package:bfit_tracker/models/goal.dart';
import 'package:bfit_tracker/models/user_info.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:height_slider/height_slider.dart';

class AboutYouScreen extends StatefulWidget {
  AboutYouScreen({Key key}) : super(key: key);

  @override
  _AboutYouScreenState createState() => _AboutYouScreenState();
}

class _AboutYouScreenState extends State<AboutYouScreen> {
  bool isMaleSelected = true;
  int height = 170;

  @override
  Widget build(BuildContext context) {
    //ignore: close_sinks
    final userInfoBloc = BlocProvider.of<UserInfoBloc>(context);

    return Scaffold(
      backgroundColor: mainTheme.primaryColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: AutoSizeText(
                'About You',
                minFontSize: 32,
                maxLines: 1,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  highlightElevation: 12,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  disabledColor: mainTheme.accentColor,
                  color: isMaleSelected ? mainTheme.accentColor : Colors.white,
                  onPressed: isMaleSelected
                      ? () {}
                      : () {
                          setState(() {
                            isMaleSelected = true;
                          });
                        },
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    constraints:
                        const BoxConstraints(minWidth: 24.0, minHeight: 52.0),
                    alignment: Alignment.center,
                    child: isMaleSelected
                        ? const AutoSizeText(
                            'Male',
                            minFontSize: 20,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          )
                        : const AutoSizeText(
                            'Male',
                            minFontSize: 20,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                  ),
                ),
                RaisedButton(
                  highlightElevation: 12,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  color:
                      isMaleSelected ? Colors.white : mainTheme.disabledColor,
                  onPressed: isMaleSelected
                      ? () {
                          setState(() {
                            isMaleSelected = false;
                          });
                        }
                      : () {},
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    constraints:
                        const BoxConstraints(minWidth: 24.0, minHeight: 52.0),
                    alignment: Alignment.center,
                    child: isMaleSelected
                        ? const AutoSizeText(
                            'Female',
                            minFontSize: 20,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          )
                        : const AutoSizeText(
                            'Female',
                            minFontSize: 20,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                  ),
                ),
              ],
            ),
            Stack(
              children: <Widget>[
                SvgPicture.asset(
                  'assets/images/onboarding/circles_4.svg',
                  fit: BoxFit.contain,
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  child: HeightSlider(
                    height: this.height,
                    numberLineColor: CustomColor.DIM_GRAY,
                    currentHeightTextColor: CustomColor.DIM_GRAY,
                    sliderCircleColor: mainTheme.accentColor,
                    onChange: (val) => setState(() => this.height = val),
                    personImagePath: isMaleSelected
                        ? 'assets/images/onboarding/man.svg'
                        : 'assets/images/onboarding/woman.svg',
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 100,
              ),
              child: RaisedButton(
                highlightElevation: 12,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {
                  final UserInfo userInfo = UserInfo(
                      height: this.height,
                      isMale: this.isMaleSelected,
                      goals: Goal(
                        bmi: 24,
                        weight: 72,
                        courses: 45,
                        gym: 100,
                        steps: 10000,
                      ));

                  userInfoBloc.add(CreateUserInfo(userInfo));

                  // Pop back to App, either go to Home or Onboarding
                  Navigator.pop(context);
                },
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                padding: const EdgeInsets.all(0.0),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[
                        mainTheme.accentColor,
                        Color(0xFF9BD8FF),
                      ],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(80.0)),
                  ),
                  child: Container(
                    constraints:
                        BoxConstraints(minWidth: 150.0, minHeight: 52.0),
                    alignment: Alignment.center,
                    child: AutoSizeText(
                      'Finish',
                      minFontSize: 20,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
