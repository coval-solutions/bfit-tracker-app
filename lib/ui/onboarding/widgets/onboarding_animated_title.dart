import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class OnboardingAnimatedTitle extends StatefulWidget {
  final String text;

  const OnboardingAnimatedTitle({Key key, this.text}) : super(key: key);

  @override
  _OnboardingAnimatedTitleState createState() =>
      _OnboardingAnimatedTitleState();
}

class _OnboardingAnimatedTitleState extends State<OnboardingAnimatedTitle> {
  bool animate = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => Future.delayed(const Duration(milliseconds: 250), () {
              setState(() {
                animate = !animate;
              });
            }));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedAlign(
      alignment: animate ? Alignment.center : Alignment.centerLeft,
      duration: const Duration(seconds: 3),
      curve: Curves.fastOutSlowIn,
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
