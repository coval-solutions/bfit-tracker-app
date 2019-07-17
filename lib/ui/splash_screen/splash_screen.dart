import 'package:bfit_tracker/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SvgPicture.asset('assets/images/rounded_logo_bf.svg'),
      backgroundColor: mainTheme.primaryColor,
    );
  }
}