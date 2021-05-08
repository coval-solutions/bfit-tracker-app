import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/controllers/user_controller.dart';
import 'package:bfit_tracker/models/goal.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:bfit_tracker/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingFinishButton extends StatelessWidget {
  final UserController userController = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => {
        userController.setGoals(Goal(
            bmi: 24,
            weight: 72,
            courses: 45,
            gym: 100,
            steps: 10000
        )),
        userController.userInfoRepository
            .create(userController.user, userController.user.userInfo),
        Get.offAllNamed(Routes.HOME),
      },
      style: buildButtonStyle(),
      child: FinishButton(),
    );
  }

  ButtonStyle buildButtonStyle() {
    return ButtonStyle(
      padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      elevation: MaterialStateProperty.resolveWith<double>(
          (Set<MaterialState> states) {
        return states.contains(MaterialState.pressed) ? 12 : 6;
      }),
      overlayColor: MaterialStateProperty.all(Colors.transparent),
    );
  }
}

class FinishButton extends StatelessWidget {
  const FinishButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            CustomColor.MAYA_BLUE,
            CustomColor.COLUMBIA_BLUE,
          ],
        ),
        borderRadius: BorderRadius.all(Radius.circular(80.0)),
      ),
      child: FinishButtonText(),
    );
  }
}

class FinishButtonText extends StatelessWidget {
  const FinishButtonText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 52.0, maxWidth: Get.width / 2),
      alignment: Alignment.center,
      child: const AutoSizeText(
        'Finish',
        minFontSize: 20,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
