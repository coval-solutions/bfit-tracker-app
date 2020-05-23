import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/models/course_detail.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:flutter/material.dart';

class CourseDetails extends StatelessWidget {
  final CourseDetail courseDetail;

  const CourseDetails({@required this.courseDetail, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainTheme.backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(0),
            elevation: 2,
            child: Column(
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
                            this.courseDetail.getImageUrl(),
                          ),
                          fit: BoxFit.cover)),
                ),
                Padding(
                    padding: EdgeInsets.all(12),
                    child: Row(
                      children: <Widget>[
                        AutoSizeText.rich(
                            TextSpan(
                              text: '111',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: mainTheme.accentColor,
                                fontSize: 28,
                                letterSpacing: 8,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'mins',
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: CustomColor.DIM_GRAY,
                                    fontSize: 16,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ],
                            ),
                            maxLines: 1),
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
