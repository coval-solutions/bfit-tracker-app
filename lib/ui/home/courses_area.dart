import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/blocs/courses/courses_bloc.dart';
import 'package:bfit_tracker/models/course.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:bfit_tracker/ui/custom.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget coursesArea() {
  final List<Color> colors = [
    CustomColor.SELECTIVE_YELLOW,
    CustomColor.MAYA_BLUE
  ];

  return BlocConsumer<CoursesBloc, CoursesState>(
    listener: (BuildContext context, CoursesState state) {},
    builder: (BuildContext context, CoursesState state) {
      print(state.props);
      if (!(state is CoursesDataLoaded) && state.props.isEmpty) {
        return Center(child: CircularProgressIndicator());
      }

      return FutureBuilder(
        future: state.props.first,
        builder: (BuildContext context, AsyncSnapshot<List<Course>> snapshot) {
          if ((snapshot.connectionState == ConnectionState.none ||
                  snapshot.connectionState == ConnectionState.waiting) ||
              snapshot.data == null) {
            return Center(child: CircularProgressIndicator());
          }

          return Scaffold(
            appBar: EmptyAppBar(),
            backgroundColor: mainTheme.backgroundColor,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8.0),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return courseCard(
                          colors[index % colors.length], snapshot.data[index]);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

Widget courseCard(Color backgroundColor, Course course) {
  return Card(
    color: backgroundColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Stack(
      children: <Widget>[
        Positioned(
          top: 6,
          left: 10,
          child: AutoSizeText(
            '${course.name}',
            maxLines: 1,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
        Positioned(
          bottom: 6,
          right: 10,
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
              maxLines: 1),
        ),
        SizedBox(
          height: 100,
          child: FlareActor('assets/animations/tonded_courses.flr',
              alignment: Alignment.center, animation: 'active'),
        ),
      ],
    ),
  );
}
