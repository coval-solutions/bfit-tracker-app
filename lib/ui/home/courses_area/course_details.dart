import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/models/course.dart';
import 'package:bfit_tracker/theme.dart';
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
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
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
                        AnimatedCount(
                          count: widget.course.courseDetail.mins,
                          animationController: this._controller,
                          textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: mainTheme.accentColor,
                            fontSize: 28,
                            letterSpacing: 8,
                          ),
                          units: 'mins',
                        ),
                        AnimatedCount(
                          count: widget.course.courseDetail.weeks,
                          animationController: this._controller,
                          textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: mainTheme.accentColor,
                            fontSize: 28,
                            letterSpacing: 8,
                          ),
                          units: 'weeks',
                        ),
                        AnimatedCount(
                          count: widget.course.courseDetail.workouts,
                          animationController: this._controller,
                          textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: mainTheme.accentColor,
                            fontSize: 28,
                            letterSpacing: 8,
                          ),
                          units: 'workouts',
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
