import 'dart:math';

import 'package:bfit_tracker/controllers/navigation_controller.dart';
import 'package:bfit_tracker/views/main/home_screen/home_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreen extends GetView<NavigationController> {
  const MainScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          index: controller.index,
          height: min(72, 52 + MediaQuery.of(context).padding.bottom),
          items: <Widget>[
            Icon(Icons.home, size: 30),
            Icon(Icons.local_dining, size: 30),
            Icon(Icons.fitness_center, size: 30),
            Icon(Icons.show_chart, size: 30),
            Icon(Icons.person, size: 30),
          ],
          onTap: (index) => controller.index = index,
        ),
        body: SafeArea(child: Obx(() => mainScreenChosen(controller.index))));
  }
}

Widget mainScreenChosen(int index) {
  switch (index) {
    case 0:
      return HomeScreen();
    case 1:
      return Text('Nutrients');
    case 2:
      return Text('Gym');
    case 3:
      return Text('Stats');
    case 4:
      return Text('Profile');
    default:
      return HomeScreen();
  }
}
