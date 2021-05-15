import 'package:bfit_tracker/views/main/home_screen/widgets/welcome_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WelcomeCard(),
      ],
    );
  }
}
