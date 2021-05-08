import 'package:bfit_tracker/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class OnboardingWeightPerson extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find();
    return SvgPicture.asset(
      "assets/images/onboarding/${userController.user.userInfo.isMale ? 'man' : 'woman'}.svg",
      height: Get.height / 2,
      fit: BoxFit.contain,
      semanticsLabel: 'Person',
    );
  }
}
