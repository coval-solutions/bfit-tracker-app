import 'package:bfit_tracker/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreenLoading extends StatelessWidget {
  const SplashScreenLoading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainTheme.primaryColor,
      body: Center(
        child: SvgPicture.asset(
          'assets/images/rounded_logo_bf.svg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
