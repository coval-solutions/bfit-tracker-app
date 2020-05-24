import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/models/course.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:bfit_tracker/ui/coval_solutions/animated_counter.dart';
import 'package:bfit_tracker/ui/custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CourseDetails extends StatefulWidget {
  final Course course;
  final Function callback;

  const CourseDetails({@required this.course, this.callback, Key key})
      : super(key: key);

  @override
  _CourseDetailsState createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails>
    with TickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
  }

  TextStyle counterTextStyle = TextStyle(
    fontWeight: FontWeight.bold,
    color: mainTheme.accentColor,
    fontSize: 28,
    letterSpacing: 4,
  );

  TextStyle counterUnitTextStyle = TextStyle(
    fontWeight: FontWeight.normal,
    color: CustomColor.DIM_GRAY,
    fontSize: 16,
  );

  @override
  Widget build(BuildContext context) {
    animationController.forward();

    return Scaffold(
      backgroundColor: mainTheme.backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(0),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.6,
                      decoration: BoxDecoration(
                          borderRadius: new BorderRadius.only(
                            bottomLeft: const Radius.circular(10.0),
                            bottomRight: const Radius.circular(10.0),
                          ),
                          image: DecorationImage(
                              image: NetworkImage(
                                this.widget.course.courseDetail.getImageUrl(),
                              ),
                              fit: BoxFit.cover)),
                    ),
                    Positioned(
                      left: 4,
                      bottom: 18,
                      child: GestureDetector(
                        onTap: () {
                          if (this.widget.callback != null) {
                            this.widget.callback();
                          }
                        },
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 6.0),
                                child: SvgPicture.asset(
                                    'assets/images/left-pointing-arrow.svg'),
                              ),
                              SizedBox(width: 6),
                              AutoSizeText(
                                widget.course.getHumanReadableName(),
                                minFontSize: 28,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )
                            ]),
                      ),
                    ),
                  ],
                ),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        AnimatedCounter(
                            count: widget.course.courseDetail.mins,
                            textStyle: counterTextStyle,
                            unitText: 'mins',
                            unitTextStyle: counterUnitTextStyle),
                        AnimatedCounter(
                            count: widget.course.courseDetail.weeks,
                            textStyle: counterTextStyle,
                            unitText: 'weeks',
                            unitTextStyle: counterUnitTextStyle),
                        AnimatedCounter(
                            count: widget.course.courseDetail.workouts,
                            textStyle: counterTextStyle,
                            unitText: 'workouts',
                            unitTextStyle: counterUnitTextStyle),
                      ],
                    )),
              ],
            ),
          ),
          Spacer(),
          SlideTransition(
            position:
                Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero)
                    .animate(animationController),
            child: Padding(
              padding: EdgeInsets.only(bottom: 24),
              child: RaisedButton(
                elevation: 2,
                onPressed: () {},
                child: AutoSizeText(
                  'Start Now',
                  maxLines: 1,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                  minFontSize: 20,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
