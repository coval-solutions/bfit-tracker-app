import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:bfit_tracker/ui/custom.dart';
import 'package:bfit_tracker/ui/home/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:height_slider/height_slider.dart';

class OnboardingScreenFour extends StatefulWidget {
  OnboardingScreenFour({Key key}) : super(key: key);

  @override
  _OnboardingScreenFourState createState() => _OnboardingScreenFourState();
}

class _OnboardingScreenFourState extends State<OnboardingScreenFour> {
  int height = 170;
  bool isMale;
  String personImagePath;

  @override
  void initState() {
    super.initState();
    isMale = true;
    personImagePath = 'assets/images/onboarding/man.svg';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EmptyAppBar(),
      backgroundColor: mainTheme.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(left: 14),
              child: AutoSizeText(
                'About You',
                minFontSize: 22,
                maxLines: 1,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                disabledColor: CustomColor.DIM_GRAY,
                color: Colors.white,
                onPressed: isMale ? null : () {
                  setState(() {
                    isMale = true;
                    personImagePath = 'assets/images/onboarding/man.svg';
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
                  child: const AutoSizeText(
                    'Male',
                    minFontSize: 20,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              RaisedButton(
                                disabledColor: CustomColor.DIM_GRAY,
                color: Colors.white,
                onPressed: isMale ? () {
                  setState(() {
                    isMale = false;
                    personImagePath = 'assets/images/onboarding/woman.svg';
                  });
                } : null,
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  constraints:
                      const BoxConstraints(minWidth: 24.0, minHeight: 52.0),
                  alignment: Alignment.center,
                  child: const AutoSizeText(
                    'Female',
                    minFontSize: 20,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
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
                  onChange: (val) => setState(() => this.height = val),
                  personImagePath: this.personImagePath,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 38, right: 38, bottom: 70),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    {}
                  },
                  child: const AutoSizeText(
                    'Skip',
                    minFontSize: 14,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
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
                          Color(0xFF6EC6FF),
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
          ),
        ],
      ),
    );
  }
}
