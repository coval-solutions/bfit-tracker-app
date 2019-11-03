import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/models/goal.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:bfit_tracker/ui/custom.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget profileInfo(user) {
  return Column(
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
    ],
  );
}

Widget totalGymTimeStat(gymTime) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    color: Colors.white,
    child: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              left: 5,
            ),
            child: AutoSizeText(
              'Total Gym Time',
              maxLines: 1,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: CustomColor.GREY_CHATEAU,
                fontSize: 14,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 6,
            ),
          ),
          LinearPercentIndicator(
            animation: true,
            lineHeight: 10.0,
            percent: gymTime,
            backgroundColor: CustomColor.LAVENDER,
            progressColor: CustomColor.SELECTIVE_YELLOW,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 4,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget otherStats(value, text, {unit}) {
  return Card(
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
          percent: value / 100,
          circularStrokeCap: CircularStrokeCap.round,
          center: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AutoSizeText.rich(
                TextSpan(
                  text: value.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: CustomColor.DIM_GRAY,
                    fontSize: 18,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: unit?.toString(),
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
                text.toString(),
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
  );
}

Widget profileArea(user, goals) {
  return FutureBuilder(
    future: goals,
    builder: (BuildContext context, AsyncSnapshot<Goal> snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.none: return Center(child: CircularProgressIndicator());
        case ConnectionState.waiting: return Center(child: CircularProgressIndicator());
        default:
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Scaffold(
              appBar: EmptyAppBar(),
              backgroundColor: mainTheme.backgroundColor,
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 16
                  ),
                  child: Column(
                    children: <Widget>[
                      profileInfo(user),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 8,
                        ),
                      ),
                      totalGymTimeStat(snapshot.data.getGym()),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 6,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          otherStats(snapshot.data.getBmi(), 'BMI Goal'),
                          Spacer(),
                          otherStats(snapshot.data.getWeight(), 'Weight Goal', unit: 'kg'),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 6,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          otherStats(snapshot.data.getCourses(), 'Course Total'),
                          Spacer(),
                          otherStats(snapshot.data.getGym(), 'Gym Goal'),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            );
          }
      }
    },
  );
}