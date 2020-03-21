// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:bfit_tracker/models/user_info.dart';
// import 'package:bfit_tracker/repositories/user_info_repository.dart';
// import 'package:bfit_tracker/theme.dart';
// import 'package:bfit_tracker/ui/custom.dart';
// import 'package:bfit_tracker/ui/home/home_screen.dart';
// import 'package:bfit_tracker/ui/onboarding/skip.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:height_slider/height_slider.dart';

// class OnboardingScreenFour extends InheritedWidget {
//   OnboardingScreenFour({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: EmptyAppBar(),
//       backgroundColor: mainTheme.primaryColor,
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: <Widget>[
//           Align(
//             alignment: Alignment.center,
//             child: Padding(
//               padding: EdgeInsets.only(left: 14),
//               child: AutoSizeText(
//                 'About You',
//                 minFontSize: 32,
//                 maxLines: 1,
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: <Widget>[
//               RaisedButton(
//                 disabledColor: CustomColor.MAYA_BLUE,
//                 color: isMaleSelected ? CustomColor.MAYA_BLUE : Colors.white,
//                 onPressed: isMaleSelected
//                     ? () {}
//                     : () {
//                         setState(() {
//                           isMaleSelected = true;
//                         });
//                       },
//                 elevation: 5,
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30.0)),
//                 padding: const EdgeInsets.all(0.0),
//                 child: Container(
//                   constraints:
//                       const BoxConstraints(minWidth: 24.0, minHeight: 52.0),
//                   alignment: Alignment.center,
//                   child: isMaleSelected
//                       ? const AutoSizeText(
//                           'Male',
//                           minFontSize: 20,
//                           style: TextStyle(
//                               color: Colors.white, fontWeight: FontWeight.bold),
//                           textAlign: TextAlign.center,
//                         )
//                       : const AutoSizeText(
//                           'Male',
//                           minFontSize: 20,
//                           style: TextStyle(
//                               color: Colors.black, fontWeight: FontWeight.bold),
//                           textAlign: TextAlign.center,
//                         ),
//                 ),
//               ),
//               RaisedButton(
//                 disabledColor: CustomColor.MAYA_BLUE,
//                 color: isMaleSelected ? Colors.white : CustomColor.MAYA_BLUE,
//                 onPressed: isMaleSelected
//                     ? () {
//                         setState(() {
//                           isMaleSelected = false;
//                         });
//                       }
//                     : () {},
//                 elevation: 5,
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30.0)),
//                 padding: const EdgeInsets.all(0.0),
//                 child: Container(
//                   constraints:
//                       const BoxConstraints(minWidth: 24.0, minHeight: 52.0),
//                   alignment: Alignment.center,
//                   child: isMaleSelected
//                       ? const AutoSizeText(
//                           'Female',
//                           minFontSize: 20,
//                           style: TextStyle(
//                               color: Colors.black, fontWeight: FontWeight.bold),
//                           textAlign: TextAlign.center,
//                         )
//                       : const AutoSizeText(
//                           'Female',
//                           minFontSize: 20,
//                           style: TextStyle(
//                               color: Colors.white, fontWeight: FontWeight.bold),
//                           textAlign: TextAlign.center,
//                         ),
//                 ),
//               ),
//             ],
//           ),
//           Stack(
//             children: <Widget>[
//               SvgPicture.asset(
//                 'assets/images/onboarding/circles_4.svg',
//                 fit: BoxFit.contain,
//               ),
//               Container(
//                 height: MediaQuery.of(context).size.height / 2,
//                 child: HeightSlider(
//                   height: this.height,
//                   numberLineColor: CustomColor.DIM_GRAY,
//                   currentHeightTextColor: CustomColor.DIM_GRAY,
//                   sliderCircleColor: CustomColor.MAYA_BLUE,
//                   onChange: (val) => setState(() => this.height = val),
//                   personImagePath: isMaleSelected
//                       ? 'assets/images/onboarding/man.svg'
//                       : 'assets/images/onboarding/woman.svg',
//                 ),
//               ),
//             ],
//           ),
//           Padding(
//             padding: EdgeInsets.only(left: 38, right: 38, bottom: 70),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 SkipOnboardingButton(),
//                 RaisedButton(
//                   onPressed: () {
//                     UserInfoRepository().setUserInfo(
//                       UserInfo(height: this.height, isMale: this.isMaleSelected)
//                     ).then((result) {
//                       Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(
//                               builder: (BuildContext context) => HomeScreen()));
//                     }).catchError((error) {
//                       // TODO: add crashanalytics shit
//                       print(error);
//                       SystemNavigator.pop();
//                     });
//                   },
//                   elevation: 5,
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
//                   padding: const EdgeInsets.all(0.0),
//                   child: Ink(
//                     decoration: const BoxDecoration(
//                       gradient: LinearGradient(
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                         colors: <Color>[
//                           CustomColor.MAYA_BLUE,
//                           Color(0xFF9BD8FF),
//                         ],
//                       ),
//                       borderRadius: BorderRadius.all(Radius.circular(80.0)),
//                     ),
//                     child: Container(
//                       constraints: const BoxConstraints(minWidth: 150.0, minHeight: 52.0),
//                       alignment: Alignment.center,
//                       child: const AutoSizeText(
//                         'Next',
//                         minFontSize: 20,
//                         style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }