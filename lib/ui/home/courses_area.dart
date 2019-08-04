import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:bfit_tracker/ui/custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget coursesArea(courses) {
  final List<Color> colors = [Colors.amber[600], CustomColor.MAYA_BLUE];
  return Scaffold(
    appBar: EmptyAppBar(),
    backgroundColor: mainTheme.backgroundColor,
    body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
        ),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: AutoSizeText(
                "Courses Available",
                maxLines: 1,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: CustomColor.DIM_GRAY,
                  fontSize: 32,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 6,
                bottom: 6,
              ),
            ),
            ListView.builder(
              scrollDirection: Axis.vertical,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true, 
              padding: const EdgeInsets.all(8.0),
              itemCount: courses.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.only(
                    top: 6,
                    bottom: 6,
                  ),
                  child: Card(
                    color: colors[index % colors.length],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            top: 18,
                          ),
                          child: AutoSizeText(
                            '${courses[index].name}',
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 12,
                          ),
                          child: SvgPicture.asset(
                            'assets/images/toned_courses.svg',
                            width: 154,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 92,
                          ),
                          child: AutoSizeText.rich(
                            TextSpan(
                              text: '0',
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
                            maxLines: 1
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 6,
                bottom: 6,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}