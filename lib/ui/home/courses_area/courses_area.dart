import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/blocs/courses/courses_bloc.dart';
import 'package:bfit_tracker/models/course.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:bfit_tracker/ui/custom.dart';
import 'package:bfit_tracker/ui/home/courses_area/course_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoursesArea extends StatefulWidget {
  CoursesArea({Key key}) : super(key: key);

  @override
  _CoursesAreaState createState() => _CoursesAreaState();
}

class _CoursesAreaState extends State<CoursesArea> {
  final List<Color> colors = [
    CustomColor.SELECTIVE_YELLOW,
    CustomColor.MAYA_BLUE
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CoursesBloc, CoursesState>(
      listener: (BuildContext context, CoursesState state) {},
      builder: (BuildContext context, CoursesState state) {
        if (!(state is CoursesDataLoaded) && state.props.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }

        return FutureBuilder(
          future: state.props.first,
          builder:
              (BuildContext context, AsyncSnapshot<List<Course>> snapshot) {
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
                        'Courses Available',
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
                        return CourseCard(
                          course: snapshot.data[index],
                          color: colors[index % colors.length],
                          duration: Duration(milliseconds: 400 * (index + 1)),
                        );
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
}
