import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/controllers/auth_controller.dart';
import 'package:bfit_tracker/controllers/user_controller.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeCard extends GetView<UserController> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      color: mainTheme.accentColor,
      child: InkWell(
        onTap: () {
          Widget cancelButton = TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
            },
          );

          Widget yesButton = TextButton(
            child: Text('Yes, Sign Out'),
            onPressed: () {
              Get.find<AuthController>().signOut();
              Navigator.pop(context);
            },
          );

          AlertDialog alert = AlertDialog(
            title: Text('Confirm Sign Out'),
            content: Text("Are you sure you would like to sign out?"),
            actions: [
              cancelButton,
              yesButton,
            ],
          );

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return alert;
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 6,
            horizontal: 8,
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: AutoSizeText(
                  "Welcome back,\n${controller.user.getForename()}!",
                  maxLines: 2,
                  maxFontSize: 24,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 22,
                  ),
                ),
              ),
              CircleAvatar(
                backgroundImage: controller.user.getDisplayPicture(),
                maxRadius: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
