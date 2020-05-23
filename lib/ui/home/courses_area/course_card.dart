import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/models/course.dart';
import 'package:bfit_tracker/ui/home/courses_area/course_details.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class CourseCard extends StatefulWidget {
  final Course course;
  final Color color;
  final Duration duration;

  CourseCard({
    Key key,
    @required this.course,
    @required this.color,
    this.duration = const Duration(milliseconds: 400),
  }) : super(key: key);

  @override
  _CourseCardState createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..forward();

    _offsetAnimation = Tween<Offset>(
      begin: Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutBack,
    ));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: GestureDetector(
        onTap: () {
          if (widget.course.courseDetail != null) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CourseDetails(course: widget.course)));
          }
        },
        child: Card(
          color: widget.color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 12,
                left: 14,
                child: AutoSizeText(
                  widget.course.getHumanReadableName(),
                  maxLines: 2,
                  minFontSize: 22,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                bottom: 6,
                right: 10,
                child: AutoSizeText.rich(
                    TextSpan(
                      text: widget.course.minutes.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'mins',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 8,
                          ),
                        ),
                      ],
                    ),
                    maxLines: 1),
              ),
              SizedBox(
                height: 128,
                child: FlareActor(
                    'assets/animations/${widget.course.animationFilename}',
                    alignment: Alignment.center,
                    animation: 'active'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
