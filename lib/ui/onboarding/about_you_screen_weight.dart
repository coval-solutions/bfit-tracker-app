import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/blocs/user_info/user_info_bloc.dart';
import 'package:bfit_tracker/models/goal.dart';
import 'package:bfit_tracker/models/user_info.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weight_slider/weight_slider.dart';

class AboutYouScreenWeight extends StatefulWidget {
  final int height;
  final bool isMale;

  AboutYouScreenWeight({Key key, this.height, this.isMale}) : super(key: key);

  @override
  _AboutYouScreenWeightState createState() => _AboutYouScreenWeightState();
}

class _AboutYouScreenWeightState extends State<AboutYouScreenWeight> {
  int weight = 80;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: mainTheme.primaryColor,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 24.0,
                left: 12.0,
                right: 12.0,
              ),
              child: Align(
                alignment: Alignment.topCenter,
                child: AutoSizeText(
                  'Now choose your weight...',
                  minFontSize: 30,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Center(
              child: SvgPicture.asset(
                'assets/images/onboarding/circles_4.svg',
                fit: BoxFit.contain,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgPicture.asset(
                  this.widget.isMale
                      ? 'assets/images/onboarding/man.svg'
                      : 'assets/images/onboarding/woman.svg',
                  fit: BoxFit.contain,
                  height: screenSize.height / 2.2,
                ),
                AspectRatio(
                  aspectRatio: 2 / 1,
                  child: WeightSlider(
                    weight: this.weight,
                    onChange: (val) => setState(() => this.weight = val),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: ElevatedButton(
                    onPressed: () {
                      final UserInfo userInfo = UserInfo(
                        height: this.widget.height,
                        isMale: this.widget.isMale,
                        weight: this.weight,
                        goals: Goal(
                          bmi: 24,
                          weight: 72,
                          courses: 45,
                          gym: 100,
                          steps: 10000,
                        ),
                      );

                      context.bloc<UserInfoBloc>()..add(CreateUserInfo(userInfo));

                      // Pop back to App, either go to Home or Onboarding
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(const EdgeInsets.all(0.0)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      elevation: MaterialStateProperty.resolveWith<double>(
                          (Set<MaterialState> states) {
                        return states.contains(MaterialState.pressed) ? 12 : 6;
                      }),
                      overlayColor: MaterialStateProperty.all(Colors.transparent),
                    ),
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
                        constraints: BoxConstraints(
                          minWidth: 150.0,
                          minHeight: 52.0,
                          maxWidth: screenSize.width / 2,
                        ),
                        alignment: Alignment.center,
                        child: const AutoSizeText(
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
            )
          ],
        ),
      ),
    );
  }
}
