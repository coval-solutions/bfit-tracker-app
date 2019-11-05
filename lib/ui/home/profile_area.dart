import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:bfit_tracker/ui/custom.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget profileArea(user) {
  return Scaffold(
    appBar: EmptyAppBar(),
    backgroundColor: mainTheme.backgroundColor,
    body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
        ),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: AutoSizeText(
                "Your Profile",
                maxLines: 1,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: CustomColor.DIM_GRAY,
                  fontSize: 32,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 6,
                bottom: 6,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AutoSizeText(
                      '${user.getName()}',
                      maxLines: 1,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: CustomColor.DIM_GRAY,
                        fontSize: 18,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 2,
                        bottom: 2,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        AutoSizeText(
                          "beginner",
                          maxLines: 1,
                          style: TextStyle(
                            color: CustomColor.DIM_GRAY,
                            fontSize: 12,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 6,
                          ),
                        ),
                        Icon(
                          FontAwesomeIcons.cogs,
                          color: CustomColor.DIM_GRAY,
                          size: 18,
                        ),
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: 24,
                  ),
                ),
                CircleAvatar(
                  minRadius: 27.5,
                  maxRadius: 55.0,
                  backgroundImage: user.displayPicture,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 12,
                bottom: 12,
              ),
            ),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 8,
                        right: 8,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                              top: 6,
                              bottom: 6,
                            ),
                          ),
                          AutoSizeText(
                            'Total Gym Time',
                            maxLines: 1,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: CustomColor.GREY_CHATEAU,
                              fontSize: 14,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 6,
                              bottom: 6,
                            ),
                          ),
                          LinearPercentIndicator(
                            animation: true,
                            lineHeight: 10.0,
                            percent: 0.5,
                            backgroundColor: CustomColor.LAVENDER,
                            progressColor: CustomColor.SELECTIVE_YELLOW,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 6,
                              bottom: 6,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 8,
                bottom: 8,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: CircularPercentIndicator(
                        animation: true,
                        radius: 120.0,
                        lineWidth: 6,
                        percent: 0.25,
                        circularStrokeCap: CircularStrokeCap.round,
                        backgroundColor: CustomColor.LAVENDER,
                        progressColor: CustomColor.MAYA_BLUE,
                        center: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            AutoSizeText(
                              '24.0',
                              maxLines: 1,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: CustomColor.DIM_GRAY,
                                fontSize: 18,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: 4,
                              ),
                            ),
                            AutoSizeText(
                              'BMI Goal',
                              maxLines: 1,
                              style: TextStyle(
                                color: CustomColor.DIM_GRAY,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                    ),
                  )
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 12,
                    right: 12,
                  ),
                ),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: CircularPercentIndicator(
                        animation: true,
                        radius: 120.0,
                        lineWidth: 6,
                        percent: 0.1,
                        circularStrokeCap: CircularStrokeCap.round,
                        center: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            AutoSizeText.rich(
                              TextSpan(
                                text: '72',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: CustomColor.DIM_GRAY,
                                  fontSize: 18,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'kg',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: CustomColor.DIM_GRAY,
                                      fontSize: 8,
                                    ),
                                  ),
                                ],
                              ),
                              maxLines: 1
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: 4,
                              ),
                            ),
                            AutoSizeText(
                              'Weight Goal',
                              maxLines: 1,
                              style: TextStyle(
                                color: CustomColor.DIM_GRAY,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        backgroundColor: CustomColor.LAVENDER,
                        progressColor: CustomColor.MAYA_BLUE,
                    ),
                  )
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: CircularPercentIndicator(
                        animation: true,
                        radius: 120.0,
                        lineWidth: 6,
                        percent: 0.1,
                        circularStrokeCap: CircularStrokeCap.round,
                        center: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            AutoSizeText(
                              '45',
                              maxLines: 1,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: CustomColor.DIM_GRAY,
                                fontSize: 18,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: 4,
                              ),
                            ),
                            AutoSizeText(
                              'Course Goal',
                              maxLines: 1,
                              style: TextStyle(
                                color: CustomColor.DIM_GRAY,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        backgroundColor: CustomColor.LAVENDER,
                        progressColor: CustomColor.MAYA_BLUE,
                    ),
                  )
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 12,
                    right: 12,
                  ),
                ),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: CircularPercentIndicator(
                        animation: true,
                        radius: 120.0,
                        lineWidth: 6,
                        percent: 0.1,
                        circularStrokeCap: CircularStrokeCap.round,
                        center: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            AutoSizeText.rich(
                              TextSpan(
                                text: '100',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: CustomColor.DIM_GRAY,
                                  fontSize: 18,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'h',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: CustomColor.DIM_GRAY,
                                      fontSize: 8,
                                    ),
                                  ),
                                ],
                              ),
                              maxLines: 1
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: 4,
                              ),
                            ),
                            AutoSizeText(
                              'Gym Goal',
                              maxLines: 1,
                              style: TextStyle(
                                color: CustomColor.DIM_GRAY,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        backgroundColor: CustomColor.LAVENDER,
                        progressColor: CustomColor.MAYA_BLUE,
                    ),
                  )
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 6,
                bottom: 6,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}