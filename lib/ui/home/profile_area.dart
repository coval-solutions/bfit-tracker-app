import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/models/goal.dart';
import 'package:bfit_tracker/models/user.dart';
import 'package:bfit_tracker/repos/goals_repository.dart';
import 'package:bfit_tracker/repos/user_repository.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:bfit_tracker/ui/custom.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileArea extends StatefulWidget {

  ProfileArea({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ProfileAreaState();
  }
}

class _ProfileAreaState extends State<ProfileArea> {
  User user;
  Future<Goal> _goals;
  
  _ProfileAreaState();

  @override
  void initState() {
    this.user = UserRepository.getCurrentUser();
    this._goals = GoalsRepository().getGoals();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EmptyAppBar(),
      backgroundColor: mainTheme.backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 4,
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
            FutureBuilder(
              future: this._goals,
              builder: (BuildContext context, AsyncSnapshot<Goal> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  default:
                    if (snapshot.hasError) {
                      return Center(
                        child: AutoSizeText('Error: ${snapshot.error}'),
                      );
                    } else if (snapshot.data == null) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Expanded(
                        child: noGlowListView(
                          <Widget>[
                            totalGymTimeStat(snapshot.data.getGym()),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 6,
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(child: otherStats(snapshot.data.getBmi(), 'BMI Goal')),
                                ),
                                Expanded(
                                  child: Container(child: otherStats(snapshot.data.getWeight(), 'Weight Goal', unit: 'kg')),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 6
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(child: otherStats(snapshot.data.getCourses(), 'Course Total')),
                                ),
                                Expanded(
                                  child: Container(child: otherStats(80, 'Daily Steps', unit: '%')),
                                ),
                              ],
                            ),                          
                          ],
                        )
                      );
                    }
                }
              }
            ),
          ],
        ),
      )
    );
  }
}

Widget profileInfo(User user) {
  return Column(
    children: <Widget>[
      Align(
        alignment: Alignment.topCenter,
        child: AutoSizeText(
          'Your Profile',
          maxLines: 1,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: CustomColor.DIM_GRAY,
          ),
          minFontSize: 26,
          maxFontSize: 26,
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(
          vertical: 6,
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AutoSizeText(
                '${user?.getName()}',
                maxLines: 1,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: CustomColor.DIM_GRAY,
                ),
                minFontSize: 16,
                maxFontSize: 18,
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
                    'beginner',
                    maxLines: 1,
                    style: TextStyle(
                      color: CustomColor.DIM_GRAY,
                    ),
                    maxFontSize: 12,
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
            maxRadius: 40,
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