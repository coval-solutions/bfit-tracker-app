import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/blocs/authentication/index.dart';
import 'package:bfit_tracker/controllers/gym_controller.dart';
import 'package:bfit_tracker/models/gym.dart';
import 'package:bfit_tracker/models/user.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:bfit_tracker/ui/custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeArea extends StatelessWidget {
  final User user;
  final Future<List<Gym>> gyms;
  final AuthenticationBloc _authenticationBloc;

  HomeArea(this.user, this.gyms, this._authenticationBloc);
  
  @override
  Widget build(BuildContext context) {
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
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  color: mainTheme.accentColor,
                  child: InkWell(
                    onTap: () {
                      Widget cancelButton = FlatButton(
                        child: Text('Cancel'),
                        onPressed:  () {
                          Navigator.pop(context);
                        },
                      );

                      Widget yesButton = FlatButton(
                        child: Text('Yes, Sign Out'),
                        onPressed:  () {
                          Navigator.pop(context);
                          _authenticationBloc.dispatch(LoggedOut());
                        },
                      );

                      AlertDialog alert = AlertDialog(
                        title: Text('Confirm Sign Out'),
                        content: Text("Are you sure you would like to sign out?"),
                        actions: [
                          cancelButton,
                          yesButton,
                        ],
                      );

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert;
                        },
                      );
                    },
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
                              "Welcome back,\n${user.getForename()}!",
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
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 4,
                  bottom: 4,
                ),
              ),
              Card(
                elevation: 2,
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
            NearByGymsCard(gyms: gyms)
          ],
        ),
      ),
    ),
  );
  }

  void setState(Null Function() param0) {}
}

class NearByGymsCard extends StatefulWidget {
  final Future<List<Gym>> gyms;

  NearByGymsCard({Key key, @required this.gyms}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NearByGymsCardState(gyms);
  }
}

class _NearByGymsCardState extends State<NearByGymsCard> {
  final Future<List<Gym>> gyms;
  int limit = 3;
  bool viewMoreButtonEnabled = true;
  
  _NearByGymsCardState(this.gyms);
  
  void loadFullList() {
    setState(() {
      this.limit = null;
      this.viewMoreButtonEnabled = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
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
                  color: mainTheme.accentColor,
                  onPressed: this.viewMoreButtonEnabled ? this.loadFullList : null,
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
                future: gyms,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Container(
                      child: Padding(
                        padding: EdgeInsets.only(
                          bottom: 18,
                        ),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    );
                  } else {
                    return ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: ClampingScrollPhysics(),
                      itemCount: this.limit ?? snapshot.data.length,
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
    );
  }
}