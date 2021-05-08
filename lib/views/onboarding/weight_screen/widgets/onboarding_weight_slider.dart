import 'package:bfit_tracker/controllers/user_controller.dart';
import 'package:bfit_tracker/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_slider/weight_slider.dart';

class OnboardingWeightSlider extends StatefulWidget {
  @override
  _OnboardingWeightSliderState createState() => _OnboardingWeightSliderState();
}

class _OnboardingWeightSliderState extends State<OnboardingWeightSlider> {
  final UserController userController = Get.find();
  int weight = 70;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 32,
        horizontal: 64,
      ),
      child: WeightSlider(
        weight: weight,
        minWeight: 40,
        maxWeight: 120,
        height: Utils.isSmallScreen() ? 64 : 84,
        onChange: (val) => {
          setState(() => weight = val),
          userController.setWeight(val),
        },
        unit: 'kg', // optional
      ),
    );
  }
}
