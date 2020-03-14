import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:bfit_tracker/ui/custom.dart';
import 'package:bfit_tracker/ui/onboarding/onboarding_screen_three.dart';
import 'package:bfit_tracker/ui/onboarding/skip.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OnboardingScreenTwo extends StatelessWidget {
  const OnboardingScreenTwo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EmptyAppBar(),
      backgroundColor: mainTheme.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Stack(
            children: <Widget>[
              SvgPicture.asset(
                'assets/images/onboarding/circles_2.svg',
                fit: BoxFit.contain,
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 170),
                  child: SvgPicture.asset(
                      'assets/images/onboarding/fitness_2.svg'),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 14),
              child: AutoSizeText(
                'Workout at home, outside\nor at the gym',
                minFontSize: 22,
                maxLines: 2,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          AutoSizeText(
            'Workout anywhere, even without\nany equipment.',
            minFontSize: 16,
            maxFontSize: 18,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          DotsIndicator(
            dotsCount: 4,
            position: 1,
            decorator: DotsDecorator(
              spacing: const EdgeInsets.only(right: 3),
              shape: CircleBorder(
                  side: BorderSide(
                color: Colors.white,
              )),
              color: CustomColor.SELECTIVE_YELLOW,
              activeColor: Colors.white,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 38, right: 38, bottom: 70),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SkipOnboardingButton(),
                RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OnboardingScreenThree()),
                    );
                  },
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  padding: const EdgeInsets.all(0.0),
                  child: Ink(
                    decoration: const BoxDecoration(
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
                      constraints: const BoxConstraints(
                          minWidth: 150.0, minHeight: 52.0),
                      alignment: Alignment.center,
                      child: const AutoSizeText(
                        'Next',
                        minFontSize: 20,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
