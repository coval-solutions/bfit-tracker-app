import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:bfit_tracker/ui/custom.dart';
import 'package:bfit_tracker/ui/onboarding/next.dart';
import 'package:bfit_tracker/ui/onboarding/onboarding_screen_four.dart';
import 'package:bfit_tracker/ui/onboarding/skip.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OnboardingScreenThree extends StatelessWidget {
  const OnboardingScreenThree({Key key}) : super(key: key);

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
                'assets/images/onboarding/circles_3.svg',
                fit: BoxFit.contain,
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 170),
                  child: SvgPicture.asset(
                      'assets/images/onboarding/fitness_3.svg'),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 14),
              child: AutoSizeText(
                'Visual technique guide\nto help working out',
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
            'Learn amazing workout skills\nby using our visual animations.',
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
            position: 2,
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
                //NextOnboardingButton(onboardingScreenWidget: OnboardingScreenFour(), replaceNavigation: true)
              ],
            ),
          )
        ],
      ),
    );
  }
}
