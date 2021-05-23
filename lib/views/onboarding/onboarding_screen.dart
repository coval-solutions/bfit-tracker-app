import 'package:bfit_tracker/theme.dart';
import 'package:bfit_tracker/views/onboarding/widgets/onboarding_stack.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:transformer_page_view/transformer_page_view.dart';

class OnboardingScreen extends StatefulWidget {
  final Stream<bool> stream;

  const OnboardingScreen({Key key, this.stream}) : super(key: key);

  @override
  OnboardingScreenState createState() {
    return new OnboardingScreenState();
  }
}

class OnboardingScreenState extends State<OnboardingScreen> {
  static const NUM_OF_PAGES = 4;
  TransformerPageController _pageController;

  static List<String> background = [
    'assets/images/onboarding/circles_1.svg',
    'assets/images/onboarding/circles_2.svg',
    'assets/images/onboarding/circles_3.svg',
  ];

  static List<String> images = [
    'assets/images/onboarding/fitness_1.svg',
    'assets/images/onboarding/fitness_2.svg',
    'assets/images/onboarding/fitness_3.svg',
  ];

  final List<String> titleText = [
    'Welcome to BFit!',
    'Workout at home, outside or at the gym',
    'Visual technique guide to help working out',
  ];

  final List<String> subtitleText = [
    'Your personalised health buddy, to maintain your physical health.',
    'Workout anywhere, even without any equipment',
    'Learn amazing workout skills by using our visual animations',
  ];

  TransformerPageView transformerPageView;

  @override
  void initState() {
    super.initState();
    _pageController = TransformerPageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainTheme.primaryColor,
      body: Center(
        child: SafeArea(
          child: transformerPageView = TransformerPageView(
            pageSnapping: true,
            loop: false,
            pageController: _pageController,
            physics: NeverScrollableScrollPhysics(),
            itemCount: NUM_OF_PAGES + 1,
            transformer: PageTransformerBuilder(
                builder: (Widget child, TransformInfo info) {
              return OnboardingStack(
                backgroundAssetPath: background[info.index],
                mainImageAssetPath: images[info.index],
                mainTitleText: titleText[info.index],
                subtitleText: subtitleText[info.index],
                transformInfo: info,
                transformerPageController: _pageController,
              );
            }),
          ),
        ),
      ),
    );
  }
}
