import 'package:bfit_tracker/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:height_slider/height_slider.dart';

class OnboardingHeightSlider extends StatefulWidget {
  @override
  _OnboardingHeightSliderState createState() => _OnboardingHeightSliderState();
}

class _OnboardingHeightSliderState extends State<OnboardingHeightSlider> {
  final UserController userController = Get.find();
  int height = 170;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0),
        child: Obx(
          () => HeightSlider(
            height: height,
            maxHeight: 170,
            minHeight: 120,
            onChange: (val) => setState(() => height = val),
            unit: 'cm',
            personImagePath:
                "assets/images/onboarding/${userController.user.userInfo.isMale ? 'man' : 'woman'}.svg",
          ),
        ),
      ),
    );
  }
}
