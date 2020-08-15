import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/models/workout.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:bfit_tracker/ui/coval_solutions/animated_counter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recase/recase.dart';

class WorkoutDetails extends StatefulWidget {
  final Workout workout;
  final Function callback;

  const WorkoutDetails({@required this.workout, this.callback, Key key})
      : super(key: key);

  @override
  _WorkoutDetailsState createState() => _WorkoutDetailsState();
}

class _WorkoutDetailsState extends State<WorkoutDetails> {
  @override
  void initState() {
    super.initState();
  }

  TextStyle counterTextStyle = TextStyle(
    fontWeight: FontWeight.bold,
    color: mainTheme.accentColor,
    letterSpacing: 4,
  );

  TextStyle counterUnitTextStyle = TextStyle(
    fontWeight: FontWeight.normal,
    color: CustomColor.DIM_GRAY,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainTheme.backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              if (this.widget.callback != null) {
                this.widget.callback();
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 28.0, left: 12.0),
              child: SvgPicture.asset(
                'assets/images/left-pointing-arrow.svg',
                color: CustomColor.DIM_GRAY,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 28.0, left: 12.0),
            child: AutoSizeText(
              widget.workout.type.titleCase,
              minFontSize: 16,
              maxFontSize: 24,
              style: TextStyle(
                  fontWeight: FontWeight.w600, color: CustomColor.DIM_GRAY),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 18.0, left: 12.0),
            child: AutoSizeText(
              widget.workout.title,
              minFontSize: 26,
              maxFontSize: 36,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: CustomColor.DIM_GRAY),
            ),
          ),
          SizedBox(height: 70),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.directions_run,
                        color: CustomColor.DIM_GRAY,
                      ),
                      AutoSizeText(
                        '${widget.workout.exercises.length} exercises',
                        minFontSize: 16,
                        maxFontSize: 18,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: CustomColor.DIM_GRAY),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.timer,
                        color: CustomColor.DIM_GRAY,
                      ),
                      AutoSizeText(
                        '${widget.workout.getWorkoutTiming()} minutes',
                        minFontSize: 16,
                        maxFontSize: 18,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: CustomColor.DIM_GRAY),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Card(
//   margin: EdgeInsets.all(0),
//   elevation: 3,
//   shape: RoundedRectangleBorder(
//     borderRadius: BorderRadius.circular(12.0),
//   ),
//   child: Column(
//     children: <Widget>[
//       Stack(
//         children: <Widget>[
//           Container(
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height * 0.6,
//             child: CachedNetworkImage(
//               placeholder: (context, url) =>
//                   Center(child: CircularProgressIndicator()),
//               errorWidget: (context, url, error) => Icon(Icons.error),
//               imageUrl: this.widget.course.courseDetail.getImageUrl(),
//               imageBuilder: (context, imageProvider) => Container(
//                 decoration: BoxDecoration(
//                     borderRadius: new BorderRadius.only(
//                       bottomLeft: const Radius.circular(10.0),
//                       bottomRight: const Radius.circular(10.0),
//                     ),
//                     image: DecorationImage(
//                         image: imageProvider, fit: BoxFit.cover)),
//               ),
//             ),
//           ),
//           Positioned(
//             left: 4,
//             bottom: 18,
//             child: GestureDetector(
//               onTap: () {
//                 if (this.widget.callback != null) {
//                   this.widget.callback();
//                 }
//               },
//               child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Padding(
//                       padding: const EdgeInsets.only(top: 6.0),
//                       child: SvgPicture.asset(
//                           'assets/images/left-pointing-arrow.svg'),
//                     ),
//                     SizedBox(width: 6),
//                     AutoSizeText(
//                       widget.course.getHumanReadableName(),
//                       minFontSize: 28,
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white),
//                     )
//                   ]),
//             ),
//           ),
//         ],
//       ),
//       Padding(
//           padding: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               AnimatedCounter(
//                   count: widget.course.courseDetail.mins,
//                   textStyle: counterTextStyle,
//                   unitText: 'mins',
//                   unitTextStyle: counterUnitTextStyle),
//               AnimatedCounter(
//                   count: widget.course.courseDetail.weeks,
//                   textStyle: counterTextStyle,
//                   unitText: 'weeks',
//                   unitTextStyle: counterUnitTextStyle),
//               AnimatedCounter(
//                   count: widget.course.courseDetail.exercises,
//                   textStyle: counterTextStyle,
//                   unitText: 'workouts',
//                   unitTextStyle: counterUnitTextStyle),
//             ],
//           )),
//     ],
//   ),
// ),
