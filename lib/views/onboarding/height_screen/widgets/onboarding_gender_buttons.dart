import 'package:bfit_tracker/controllers/user_controller.dart';
import 'package:bfit_tracker/views/onboarding/height_screen/widgets/onboarding_gender_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingGenderButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetX<UserController>(
      builder: (controller) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          OnboardingGenderButton(
            isMale: true,
            canOnPress: !controller.user.userInfo.isMale,
          ),
          OnboardingGenderButton(
            isMale: false,
            canOnPress: controller.user.userInfo.isMale,
          ),
        ],
      ),
    );
  }
}
