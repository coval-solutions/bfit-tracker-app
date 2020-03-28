import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/blocs/authentication/authentication_bloc.dart';
import 'package:bfit_tracker/controllers/gym_controller.dart';
import 'package:bfit_tracker/models/gym.dart';
import 'package:bfit_tracker/models/user.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:bfit_tracker/ui/custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class HomeArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 12,
          ),
          child: Column(
            children: <Widget>[
              WelcomeCard(),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 6,
                ),
              ),
              AspectRatio(
                aspectRatio: 3 / 2,
                child: ArticlesCard(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 6,
                ),
              ),
              // Expanded(
              //   child: NearByGymsCard(),
              // ),
            ],
          ),
        ));
  }
}

class WelcomeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //ignore: close_sinks
    final AuthenticationBloc _authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      color: mainTheme.accentColor,
      child: StreamBuilder<User>(
          stream: _authenticationBloc.state.props.first,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return InkWell(
                onTap: () {
                  Widget cancelButton = FlatButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  );

                  Widget yesButton = FlatButton(
                    child: Text('Yes, Sign Out'),
                    onPressed: () {
                      _authenticationBloc.add(LoggedOut());
                      Navigator.pop(context);
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
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 8,
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: AutoSizeText(
                          "Welcome back,\n${snapshot.data.getForename()}!",
                          maxLines: 2,
                          maxFontSize: 24,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 22,
                          ),
                        ),
                      ),
                      CircleAvatar(
                        backgroundImage: snapshot.data.getDisplayPicture(),
                        maxRadius: 40,
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}

class ArticlesCard extends StatelessWidget {
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
          Expanded(
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: SvgPicture.asset(
                      'assets/images/undraw_healthy_habit.svg',
                    ),
                  ),
                ),
                Positioned(
                  top: 2,
                  right: 12,
                  child: ButtonTheme(
                    minWidth: 68,
                    height: 24,
                    child: RaisedButton(
                      padding: EdgeInsets.all(0),
                      disabledColor: mainTheme.accentColor,
                      onPressed: null,
                      child: AutoSizeText(
                        '5 min read',
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
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
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              constraints: const BoxConstraints(
                minWidth: double.infinity,
              ),
              decoration: BoxDecoration(
                color: mainTheme.primaryColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(12.0),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 6,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topCenter,
                      child: AutoSizeText(
                        '10 Ways To Stay Motivated At The Gym',
                        maxLines: 2,
                        minFontSize: 16,
                        maxFontSize: 32,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 3,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                      child: AutoSizeText(
                        'Find out the best kept secrets from the one and only Nick Mitchell!',
                        maxLines: 2,
                        minFontSize: 12,
                        maxFontSize: 28,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        right: 16,
                      ),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: AutoSizeText(
                          'Dr. Divyesh Vala',
                          maxLines: 1,
                          maxFontSize: 12,
                          style: TextStyle(
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                          ),
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
    );
  }
}

class NearByGymsCard extends StatefulWidget {
  NearByGymsCard({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NearByGymsCardState();
  }
}

class _NearByGymsCardState extends State<NearByGymsCard> {
  Future<List<Gym>> _gyms;

  _NearByGymsCardState();

  @override
  void initState() {
    this._gyms = null; //GymsRepository().getGyms();
    super.initState();
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
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 12,
            ),
            child: Container(
              child: AutoSizeText(
                "Gyms Near Me",
                maxLines: 1,
                minFontSize: 18,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: this._gyms,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Center(child: CircularProgressIndicator());
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                  default:
                    if (snapshot.hasError) {
                      return Center(
                          child: AutoSizeText('Error: ${snapshot.error}'));
                    } else if (snapshot.data == null) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return ListView.separated(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                                title: AutoSizeText(
                                  '${snapshot.data[index].name}',
                                  maxLines: 1,
                                  maxFontSize: 14,
                                ),
                                subtitle: AutoSizeText(
                                  '${snapshot.data[index].address}',
                                  maxLines: 1,
                                  minFontSize: 8,
                                  maxFontSize: 10,
                                ),
                                onTap: () {
                                  GymController.launchGoogleMaps(
                                      snapshot.data[index].lat,
                                      snapshot.data[index].lng);
                                });
                          },
                          separatorBuilder: (context, index) {
                            return Divider(height: 1);
                          });
                    }
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
