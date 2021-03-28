import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:bfit_tracker/ui/onboarding/about_you_screen_height.dart';
import 'package:flutter/material.dart';
import 'package:transformer_page_view/transformer_page_view.dart';

class NextOnboardingButton extends StatelessWidget {
  final TransformerPageView transformerPageView;

  NextOnboardingButton(this.transformerPageView);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (transformerPageView.pageController.hasClients) {
          switch (transformerPageView.pageController.page.toInt()) {
            case 2:
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      AboutYouScreenHeight(
                          transformerPageView: transformerPageView),
                  transitionDuration: Duration(milliseconds: 400),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return SlideTransition(
                      position: Tween<Offset>(
                              begin: Offset(1.0, 0.0), end: Offset.zero)
                          .animate(CurvedAnimation(
                              parent: animation, curve: Curves.easeInOut)),
                      child: child,
                    );
                  },
                ),
              );
              break;
            default:
              transformerPageView.pageController.nextPage(
                  duration: Duration(milliseconds: 400),
                  curve: Curves.easeInOut);
              break;
          }
        }
      },
      style: ButtonStyle(
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
      ),
      child: Ink(
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
        child: Container(
          constraints: const BoxConstraints(minWidth: 150.0, minHeight: 52.0),
          alignment: Alignment.center,
          child: const AutoSizeText(
            'Next',
            minFontSize: 20,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
