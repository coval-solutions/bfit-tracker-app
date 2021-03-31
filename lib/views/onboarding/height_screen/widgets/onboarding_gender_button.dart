import 'package:bfit_tracker/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class OnboardingGenderButton extends GetView<UserController> {
  final bool isMale;

  OnboardingGenderButton({this.isMale = true});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: SvgPicture.asset(
        "assets/images/onboarding/${this.isMale ? 'man' : 'woman'}_face.svg",
        semanticsLabel: 'Face of a ${this.isMale ? 'man' : 'woman'}',
      ),
    );
  }
}
