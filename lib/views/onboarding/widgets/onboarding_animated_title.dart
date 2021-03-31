import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class OnboardingAnimatedTitle extends StatefulWidget {
  final String text;

  const OnboardingAnimatedTitle({Key key, this.text}) : super(key: key);

  @override
  _OnboardingAnimatedTitleState createState() =>
      _OnboardingAnimatedTitleState();
}

class _OnboardingAnimatedTitleState extends State<OnboardingAnimatedTitle>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<Offset> offset;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    offset = Tween<Offset>(begin: Offset(-30, 0), end: Offset(0.0, 0))
        .animate(controller);

    WidgetsBinding.instance.addPostFrameCallback((_) => controller.forward());
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: offset,
      child: AutoSizeText(
        widget.text,
        minFontSize: 24,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
