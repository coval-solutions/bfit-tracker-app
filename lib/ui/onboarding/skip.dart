import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/ui/onboarding/about_you_screen.dart';
import 'package:flutter/material.dart';

class SkipOnboardingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                AboutYouScreen(),
            transitionDuration: Duration(milliseconds: 400),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position:
                    Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset.zero)
                        .animate(CurvedAnimation(
                            parent: animation, curve: Curves.easeInOut)),
                child: child,
              );
            },
          ),
        );
      },
      child: const AutoSizeText(
        'Skip',
        minFontSize: 14,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
