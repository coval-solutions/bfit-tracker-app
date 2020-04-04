import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/blocs/user_info/user_info_bloc.dart';
import 'package:bfit_tracker/models/goal.dart';
import 'package:bfit_tracker/models/user_info.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:bfit_tracker/ui/custom.dart';
import 'package:bfit_tracker/ui/onboarding/onboarding_screen.dart';
import 'package:dots_indicator/dots_indicator.dart';
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
      appBar: EmptyAppBar(),
      backgroundColor: mainTheme.primaryColor,
      body: Column(
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
                disabledColor: CustomColor.MAYA_BLUE,
                color: isMaleSelected ? CustomColor.MAYA_BLUE : Colors.white,
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
                              color: Colors.white, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        )
                      : const AutoSizeText(
                          'Male',
                          minFontSize: 20,
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                ),
              ),
              RaisedButton(
                disabledColor: CustomColor.MAYA_BLUE,
                color: isMaleSelected ? Colors.white : CustomColor.MAYA_BLUE,
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
                              color: Colors.black, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        )
                      : const AutoSizeText(
                          'Female',
                          minFontSize: 20,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
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
                  sliderCircleColor: CustomColor.MAYA_BLUE,
                  onChange: (val) => setState(() => this.height = val),
                  personImagePath: isMaleSelected
                      ? 'assets/images/onboarding/man.svg'
                      : 'assets/images/onboarding/woman.svg',
                ),
              ),
            ],
          ),
          DotsIndicator(
            dotsCount: OnboardingScreenState.NUM_OF_PAGES + 1,
            position: (OnboardingScreenState.NUM_OF_PAGES + 1).toDouble() - 1,
            decorator: DotsDecorator(
              spacing: EdgeInsets.only(right: 3),
              shape: CircleBorder(
                  side: BorderSide(
                color: Colors.white,
              )),
              color: CustomColor.SELECTIVE_YELLOW,
              activeColor: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 100,
            ),
            child: RaisedButton(
              onPressed: () {
                final UserInfo userInfo = UserInfo(
                  height: this.height,
                  isMale: this.isMaleSelected,
                  goals: Goal(
                    bmi: 24,
                    weight: 72,
                    courses: 45,
                    gym: 100
                  )
                );

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
                      CustomColor.MAYA_BLUE,
                      Color(0xFF9BD8FF),
                    ],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(80.0)),
                ),
                child: Container(
                  constraints: BoxConstraints(minWidth: 150.0, minHeight: 52.0),
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
    );
  }
}
