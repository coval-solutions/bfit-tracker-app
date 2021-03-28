import 'package:bfit_tracker/theme.dart';
import 'package:bfit_tracker/ui/onboarding/next.dart';
import 'package:bfit_tracker/ui/onboarding/widgets/onboarding_skip_button.dart';
import 'package:bfit_tracker/ui/onboarding/widgets/onboarding_stack.dart';
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
      body: SafeArea(
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
            );
          }),
        ),
      ),
    );
    // return Scaffold(
    //   backgroundColor: mainTheme.primaryColor,
    //   body: SafeArea(
    //     child: Stack(
    //       children: <Widget>[
    //         transformerPageView = TransformerPageView(
    //           pageSnapping: true,
    //           loop: false,
    //           pageController: _pageController,
    //           physics: NeverScrollableScrollPhysics(),
    //           itemCount: NUM_OF_PAGES,
    //           transformer: PageTransformerBuilder(
    //               builder: (Widget child, TransformInfo info) {
    //             return Material(
    //               color: mainTheme.primaryColor,
    //               textStyle: TextStyle(color: Colors.white),
    //               child: Container(
    //                 child: Padding(
    //                   padding: const EdgeInsets.all(18.0),
    //                   child: Column(
    //                     mainAxisAlignment: MainAxisAlignment.start,
    //                     crossAxisAlignment: CrossAxisAlignment.center,
    //                     children: <Widget>[
    //                       Stack(
    //                         children: <Widget>[
    //                           ParallaxContainer(
    //                             child: SvgPicture.asset(
    //                               this.background[info.index],
    //                               fit: BoxFit.contain,
    //                             ),
    //                             position: info.position,
    //                             translationFactor: 200.0,
    //                           ),
    //                           Align(
    //                             alignment: Alignment.bottomCenter,
    //                             child: ParallaxContainer(
    //                               child: SvgPicture.asset(
    //                                 this.images[info.index],
    //                                 fit: BoxFit.scaleDown,
    //                                 height: MediaQuery.of(context).size.width,
    //                               ),
    //                               position: info.position,
    //                               translationFactor: 800.0,
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //                       ParallaxContainer(
    //                         child: Padding(
    //                           padding:
    //                               const EdgeInsets.symmetric(horizontal: 12),
    //                           child: AutoSizeText(
    //                             this.titleText[info.index],
    //                             minFontSize: 24,
    //                             maxLines: 2,
    //                             style: TextStyle(
    //                               color: Colors.white,
    //                               fontWeight: FontWeight.bold,
    //                             ),
    //                           ),
    //                         ),
    //                         position: info.position,
    //                         opacityFactor: .8,
    //                         translationFactor: 400.0,
    //                       ),
    //                       SizedBox(
    //                         height: 16,
    //                       ),
    //                       ParallaxContainer(
    //                         child: Padding(
    //                           padding:
    //                               const EdgeInsets.symmetric(horizontal: 12),
    //                           child: AutoSizeText(
    //                             this.subtitleText[info.index],
    //                             minFontSize: 16,
    //                             maxFontSize: 18,
    //                             maxLines: 3,
    //                             textAlign: TextAlign.center,
    //                             style: TextStyle(
    //                               color: Colors.white,
    //                               fontWeight: FontWeight.w600,
    //                             ),
    //                           ),
    //                         ),
    //                         position: info.position,
    //                         translationFactor: 300.0,
    //                       ),
    //                       SizedBox(
    //                         height: 28,
    //                       ),
    //                       OnboardingDotsIndicator(
    //                         dotsCount: NUM_OF_PAGES + 1,
    //                         currentDotPosition: transformerPageView.pageController.hasClients ? transformerPageView.pageController.page : 0,
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             );
    //           }),
    //         ),
    //         Align(
    //           alignment: Alignment.bottomCenter,
    //           child: Padding(
    //             padding: EdgeInsets.only(
    //                 bottom: 16.0 + MediaQuery.of(context).padding.bottom),
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: <Widget>[
    //                 skipButton(),
    //                 nextButton(transformerPageView),
    //               ],
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }

  Widget nextButton(TransformerPageView transformerPageView) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: 164,
        maxHeight: 64,
      ),
      padding: const EdgeInsets.all(10),
      child: NextOnboardingButton(transformerPageView),
    );
  }

  Widget skipButton() {
    return Container(
      constraints: BoxConstraints(
        maxWidth: 164,
        maxHeight: 64,
      ),
      padding: const EdgeInsets.all(16),
      child: SkipOnboardingButton(),
    );
  }
}
