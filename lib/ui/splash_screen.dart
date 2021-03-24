import 'package:bfit_tracker/controllers/auth_controller.dart';
import 'package:bfit_tracker/controllers/user_controller.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:bfit_tracker/ui/home/home_screen.dart';
import 'package:bfit_tracker/ui/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SplashScreenLoading extends GetWidget<AuthController> {
  const SplashScreenLoading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find<UserController>();
    // controller.signOut();
    return Obx(() =>
        controller.getUser() != null ? (userController?.user?.userInfo != null ?
        HomeScreen() : OnboardingScreen()) : SplashScreen());
  }
}

class SplashScreen extends GetWidget<AuthController> {
  @override
  Widget build(BuildContext context) {
    controller.signInWithGoogle();
    return Scaffold(
      backgroundColor: mainTheme.primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SvgPicture.asset(
          'assets/images/rounded_logo_bf.svg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
