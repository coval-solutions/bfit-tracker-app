import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/controllers/gym_controller.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../custom.dart';

Widget homeArea(user, location) {
  return Scaffold(
    appBar: EmptyAppBar(),
    backgroundColor: mainTheme.backgroundColor,
    body: Padding(
      padding: EdgeInsets.only(
        left: 12,
        right: 12,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                left: 12,
                right: 12
              ),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                color: mainTheme.accentColor,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(
                          left: 12,
                          right: 0,
                          top: 6,
                          bottom: 6
                        ),
                        child: AutoSizeText(
                          "Welcome back,\n${user.shortName}!",
                          maxLines: 2,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 0,
                        right: 8,
                        top: 6,
                        bottom: 6
                      ),
                      child: CircleAvatar(
                        minRadius: 27.5,
                        maxRadius: 55.0,
                        backgroundImage: user.displayPicture,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 4,
                bottom: 4,
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          top: 8,
                          left: 12,
                          bottom: 8,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: SvgPicture.asset(
                            'assets/images/undraw_healthy_habit.svg',
                            height: 164,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 8,
                          right: 8,
                        ),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: RaisedButton(
                            padding: EdgeInsets.all(6),
                            disabledColor: mainTheme.accentColor,
                            onPressed: null,
                            child: AutoSizeText(
                              "5 min read",
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: mainTheme.primaryColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(12.0),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                AutoSizeText(
                                  "10 Ways To Stay Motivated At The Gym",
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 24,
                                  ),
                                ),
                                SizedBox(height: 8),
                                AutoSizeText(
                                  "Find out the best kept secrets from the one and only Nick Mitchell",
                                  maxLines: 2,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: AutoSizeText(
                                    "Dr. Divyesh Vala",
                                    maxLines: 1,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(
                            left: 12,
                            right: 0,
                            top: 6,
                            bottom: 6
                          ),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: AutoSizeText(
                              "Gyms Near By",
                              maxLines: 1,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 0,
                          right: 8,
                          top: 6,
                          bottom: 6
                        ),
                        child: RaisedButton(
                          padding: EdgeInsets.all(6),
                          disabledColor: mainTheme.accentColor,
                          onPressed: null,
                          child: AutoSizeText(
                            "View More",
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(padding:
                    EdgeInsets.only(
                      top: 2,
                      bottom: 2
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      FutureBuilder(
                        future: GymController.getGyms(location.latitude, location.longitude),
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if(snapshot.data == null){
                            return Container(
                              child: Center(
                                child: Text("Loading...")
                              )
                            );
                          } else {
                            return ListView.separated(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: AutoSizeText('${snapshot.data[index].name}'),
                                  subtitle: AutoSizeText('${snapshot.data[index].address}'),
                                  onTap: () {
                                    GymController.launchGoogleMaps(snapshot.data[index].lat, snapshot.data[index].lng);
                                  }
                                );
                              },
                              separatorBuilder: (context, index) {
                                return Divider(height: 1);
                              },
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    ),
  ),
);
}