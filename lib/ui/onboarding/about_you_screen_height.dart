import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:bfit_tracker/ui/onboarding/about_you_screen_weight.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:height_slider/height_slider.dart';
import 'package:transformer_page_view/transformer_page_view.dart';

class AboutYouScreenHeight extends StatefulWidget {
  final TransformerPageView transformerPageView;

  AboutYouScreenHeight({Key key, this.transformerPageView}) : super(key: key);

  @override
  _AboutYouScreenHeightState createState() => _AboutYouScreenHeightState();
}

class _AboutYouScreenHeightState extends State<AboutYouScreenHeight> {
  bool isMaleSelected = true;
  int height = 170;

  @override
  Widget build(BuildContext context) {
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
                ElevatedButton(
                  onPressed: isMaleSelected
                      ? () {}
                      : () {
                          setState(() {
                            isMaleSelected = true;
                          });
                        },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    elevation: MaterialStateProperty.resolveWith<double>(
                        (Set<MaterialState> states) {
                      return states.contains(MaterialState.pressed) ? 12 : 6;
                    }),
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      return states.contains(MaterialState.disabled)
                          ? mainTheme.accentColor
                          : isMaleSelected
                              ? mainTheme.accentColor
                              : Colors.white;
                    }),
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                  ),
                  child: Container(
                    constraints:
                        const BoxConstraints(minWidth: 74.0, minHeight: 52.0),
                    alignment: Alignment.center,
                    child: isMaleSelected
                        ? const AutoSizeText(
                            'Male',
                            minFontSize: 20,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          )
                        : const AutoSizeText(
                            'Male',
                            minFontSize: 20,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                  ),
                ),
                ElevatedButton(
                  onPressed: isMaleSelected
                      ? () {
                          setState(() {
                            isMaleSelected = false;
                          });
                        }
                      : () {},
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    elevation: MaterialStateProperty.resolveWith<double>(
                        (Set<MaterialState> states) {
                      return states.contains(MaterialState.pressed) ? 12 : 6;
                    }),
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      return states.contains(MaterialState.disabled)
                          ? mainTheme.accentColor
                          : isMaleSelected
                              ? Colors.white
                              : mainTheme.disabledColor;
                    }),
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                  ),
                  child: Container(
                    constraints:
                        const BoxConstraints(minWidth: 74.0, minHeight: 52.0),
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
                // RaisedButton(
                //   highlightElevation: 12,
                //   splashColor: Colors.transparent,
                //   highlightColor: Colors.transparent,
                //   color:
                //       isMaleSelected ? Colors.white : mainTheme.disabledColor,
                //   onPressed: isMaleSelected
                //       ? () {
                //           setState(() {
                //             isMaleSelected = false;
                //           });
                //         }
                //       : () {},
                //   elevation: 5,
                //   shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(30.0)),
                //   padding: const EdgeInsets.all(0.0),
                //   child: Container(
                //     constraints:
                //         const BoxConstraints(minWidth: 24.0, minHeight: 52.0),
                //     alignment: Alignment.center,
                //     child: isMaleSelected
                //         ? const AutoSizeText(
                //             'Female',
                //             minFontSize: 20,
                //             style: TextStyle(
                //                 color: Colors.black,
                //                 fontWeight: FontWeight.bold),
                //             textAlign: TextAlign.center,
                //           )
                //         : const AutoSizeText(
                //             'Female',
                //             minFontSize: 20,
                //             style: TextStyle(
                //                 color: Colors.white,
                //                 fontWeight: FontWeight.bold),
                //             textAlign: TextAlign.center,
                //           ),
                //   ),
                // ),
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
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          AboutYouScreenWeight(
                        height: this.height,
                        isMale: this.isMaleSelected,
                      ),
                      transitionDuration: Duration(milliseconds: 400),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return SlideTransition(
                          position: Tween<Offset>(
                                  begin: Offset(1.0, 0.0), end: Offset.zero)
                              .animate(CurvedAnimation(
                                  parent: animation, curve: Curves.easeInOut)),
                          child: child,
                        );
                      },
                    ),
                  );
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
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
                    constraints:
                        const BoxConstraints(minWidth: 150.0, minHeight: 52.0),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
