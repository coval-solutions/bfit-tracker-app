import 'package:bfit_tracker/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class OnboardingGenderButton extends GetView<UserController> {
  final bool isMale;
  final bool canOnPress;

  OnboardingGenderButton({this.isMale = true, this.canOnPress});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: canOnPress ? () => controller.setIsMale(isMale) : null,
      style: buildButtonStyle(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
        child: SvgPicture.asset(
          "assets/images/onboarding/${this.isMale ? 'man' : 'woman'}_face.svg",
          semanticsLabel: 'Face of a ${this.isMale ? 'man' : 'woman'}',
        ),
      ),
    );
  }

  ButtonStyle buildButtonStyle() {
    return ButtonStyle(
      padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
      // backgroundColor: MaterialStateProperty.all(Colors.white),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      elevation: MaterialStateProperty.resolveWith<double>(
          (Set<MaterialState> states) {
        return states.contains(MaterialState.pressed) ? 12 : 6;
      }),
    );
  }
}
