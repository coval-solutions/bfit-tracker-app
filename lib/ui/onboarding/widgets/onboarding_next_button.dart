import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:flutter/material.dart';

class OnboardingNextButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => {},
      style: buildButtonStyle(),
      child: NextButton(),
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

class NextButton extends StatelessWidget {
  const NextButton({
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
      child: NextButtonText(),
    );
  }
}

class NextButtonText extends StatelessWidget {
  const NextButtonText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 150.0, minHeight: 52.0),
      alignment: Alignment.center,
      child: const AutoSizeText(
        'Next',
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
