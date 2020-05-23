import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/models/course.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CourseDetails extends StatelessWidget {
  final Course course;

  const CourseDetails({@required this.course, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainTheme.backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(0),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.6,
                      decoration: BoxDecoration(
                          borderRadius: new BorderRadius.only(
                            bottomLeft: const Radius.circular(10.0),
                            bottomRight: const Radius.circular(10.0),
                          ),
                          image: DecorationImage(
                              image: NetworkImage(
                                this.course.courseDetail.getImageUrl(),
                              ),
                              fit: BoxFit.cover)),
                    ),
                    Positioned(
                      left: 4,
                      bottom: 18,
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 6.0),
                                child: SvgPicture.asset(
                                    'assets/images/left-pointing-arrow.svg'),
                              ),
                              SizedBox(width: 6),
                              AutoSizeText(
                                course.getHumanReadableName(),
                                minFontSize: 28,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )
                            ]),
                      ),
                    ),
                  ],
                ),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        AutoSizeText.rich(
                            TextSpan(
                              text: '111',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: mainTheme.accentColor,
                                fontSize: 28,
                                letterSpacing: 8,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'mins',
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: CustomColor.DIM_GRAY,
                                    fontSize: 16,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ],
                            ),
                            maxLines: 1),
                        AutoSizeText.rich(
                            TextSpan(
                              text: '11',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: mainTheme.accentColor,
                                fontSize: 28,
                                letterSpacing: 8,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'weeks',
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: CustomColor.DIM_GRAY,
                                    fontSize: 16,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ],
                            ),
                            maxLines: 1),
                        AutoSizeText.rich(
                            TextSpan(
                              text: '11',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: mainTheme.accentColor,
                                fontSize: 28,
                                letterSpacing: 8,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'workouts',
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: CustomColor.DIM_GRAY,
                                    fontSize: 16,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ],
                            ),
                            maxLines: 1),
                      ],
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
