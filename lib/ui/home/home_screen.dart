import 'package:bfit_tracker/blocs/bottom_nav_bar/home_screen_bottom_nav_bar_bloc.dart';
import 'package:bfit_tracker/blocs/user_info/user_info_bloc.dart';
import 'package:bfit_tracker/models/user_info.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:bfit_tracker/ui/home/analytics_area/analytics_area.dart';
import 'package:bfit_tracker/ui/home/home_area.dart';
import 'package:bfit_tracker/ui/home/profile_area/profile_area.dart';
import 'package:bfit_tracker/ui/home/targets_area.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final UserInfo userInfo;

  HomeScreen({Key key, this.userInfo}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenBottomNavBarBloc _bottomNavBarBloc;

  @override
  void initState() {
    super.initState();
    this._bottomNavBarBloc = HomeScreenBottomNavBarBloc();
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
            default:
              return _homeArea();
          }
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
    return HomeArea();
  }

  Widget _targetArea() {
    return targetsArea();
  }

  Widget _coursesArea() {
    return CircularProgressIndicator();
    // return coursesArea(courses);
  }

  Widget _analyticsArea() {
    return AnalyticsArea();
  }

  Widget _profileArea() {
    return ProfileArea(widget.userInfo);
  }
}