import 'dart:math';

import 'package:bfit_tracker/blocs/bottom_nav_bar/home_screen_bottom_nav_bar_bloc.dart';
import 'package:bfit_tracker/models/user_info.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:bfit_tracker/views/home/analytics_area/analytics_area.dart';
import 'package:bfit_tracker/views/home/home_area/home_area.dart';
import 'package:bfit_tracker/views/home/nutrition_area/nutrition_area.dart';
import 'package:bfit_tracker/views/home/profile_area/profile_area.dart';
import 'package:bfit_tracker/views/home/workouts_area/workouts_area.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final UserInfo userInfo;
  final HomeScreenBottomNavBarItems navBarItem;

  HomeScreen({Key key, this.userInfo, this.navBarItem}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenBottomNavBarBloc _bottomNavBarBloc;

  @override
  void initState() {
    this._bottomNavBarBloc = HomeScreenBottomNavBarBloc();
    super.initState();
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
        initialData: this.widget.navBarItem ?? _bottomNavBarBloc.defaultItem,
        builder: (BuildContext context,
            AsyncSnapshot<HomeScreenBottomNavBarItems> snapshot) {
          switch (snapshot.data) {
            case HomeScreenBottomNavBarItems.HOME:
              return _homeArea();
            case HomeScreenBottomNavBarItems.NUTRITION:
              return _nutritionArea();
            case HomeScreenBottomNavBarItems.COURSES:
              return _workoutsArea();
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
        initialData: this.widget.navBarItem ?? _bottomNavBarBloc.defaultItem,
        builder: (BuildContext context,
            AsyncSnapshot<HomeScreenBottomNavBarItems> snapshot) {
          return CurvedNavigationBar(
            index: this.widget.navBarItem?.index ??
                _bottomNavBarBloc.defaultItem.index,
            height: min(72, 52 + MediaQuery.of(context).padding.bottom),
            backgroundColor: mainTheme.accentColor,
            items: <Widget>[
              Icon(Icons.home, size: 30),
              Icon(Icons.local_dining, size: 30),
              Icon(Icons.fitness_center, size: 30),
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

  Widget _nutritionArea() {
    return NutritionArea();
  }

  Widget _workoutsArea() {
    return WorkoutsArea();
  }

  Widget _analyticsArea() {
    return AnalyticsArea();
  }

  Widget _profileArea() {
    return ProfileArea(widget.userInfo);
  }
}