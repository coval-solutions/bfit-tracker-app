import 'package:bfit_tracker/blocs/authentication/index.dart';
import 'package:bfit_tracker/blocs/bottom_nav_bar/index.dart';
import 'package:bfit_tracker/controllers/gym_controller.dart';
import 'package:bfit_tracker/models/course.dart';
import 'package:bfit_tracker/models/gym.dart';
import 'package:bfit_tracker/models/user.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:bfit_tracker/ui/home/home_area.dart';
import 'package:bfit_tracker/ui/home/index.dart';
import 'package:bfit_tracker/ui/home/targets_area.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatefulWidget {
  final User user;
  final Position location;
  final List<Course> courses;

  HomeScreen({Key key, @required this.user, this.location, this.courses}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState(user, location, courses);
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final User user;
  final Position location;
  final List<Course> courses;
  HomeScreenBottomNavBarBloc _bottomNavBarBloc;
  AuthenticationBloc _authenticationBloc;
  Future<List<Gym>> gyms;

  _HomeScreenState(this.user, this.location, this.courses);

  @override
  void initState() {
    super.initState();
    this._bottomNavBarBloc = HomeScreenBottomNavBarBloc();
    this._authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    this.gyms = GymController.getGyms(this.location.latitude, this.location.longitude);
  }

  @override
  void dispose() {
    _bottomNavBarBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainTheme.backgroundColor,
      body: StreamBuilder<HomeScreenBottomNavBarItems>(
        stream: _bottomNavBarBloc.itemStream,
        initialData: _bottomNavBarBloc.defaultItem,
        builder: (BuildContext context, AsyncSnapshot<HomeScreenBottomNavBarItems> snapshot) {
          switch (snapshot.data) {
            case HomeScreenBottomNavBarItems.HOME:
              return _homeArea();
            case HomeScreenBottomNavBarItems.TARGETS:
              return _targetArea();
            case HomeScreenBottomNavBarItems.COURSES:
              return _coursesArea();
            case HomeScreenBottomNavBarItems.ANALYTICS:
              return _analyticsArea();
            case HomeScreenBottomNavBarItems.PROFILE:
              return _profileArea();
          }

          return _homeArea(); 
        },
      ),
      bottomNavigationBar: StreamBuilder(
        stream: _bottomNavBarBloc.itemStream,
        initialData: _bottomNavBarBloc.defaultItem,
          builder: (BuildContext context, AsyncSnapshot<HomeScreenBottomNavBarItems> snapshot) {
          return CurvedNavigationBar(
            backgroundColor: mainTheme.accentColor,
            items: <Widget>[
              Icon(Icons.home, size: 30),
              Icon(Icons.gps_fixed, size: 30),
              Icon(Icons.lightbulb_outline, size: 30),
              Icon(Icons.show_chart, size: 30),
              Icon(Icons.person, size: 30),
            ],
            onTap: (index) {
              _bottomNavBarBloc.pickItem(index);
            },
          );
        },
      ),
    );
  }

  Widget _homeArea() {
    return homeArea(user, gyms, _authenticationBloc);
  }

  Widget _targetArea() {
    return targetsArea();
  }

  Widget _coursesArea() {
    return coursesArea(courses);
  }

  Widget _analyticsArea() {
    return analyticsArea();
  }

  Widget _profileArea() {
    return profileArea(user);
  }
}