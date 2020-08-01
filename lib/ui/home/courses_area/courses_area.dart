import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/blocs/workout/workout_bloc.dart';
import 'package:bfit_tracker/models/workout.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:bfit_tracker/ui/coval_solutions/empty_app_bar.dart';
import 'package:bfit_tracker/ui/home/courses_area/course_card.dart';
import 'package:bfit_tracker/ui/home/courses_area/course_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoursesArea extends StatefulWidget {
  CoursesArea({Key key}) : super(key: key);

  @override
  _CoursesAreaState createState() => _CoursesAreaState();
}

class _CoursesAreaState extends State<CoursesArea> {
  final List<Color> colors = [mainTheme.primaryColor, mainTheme.accentColor];
  bool showDetails = false;
  Workout courseSelected;

  void hideDetails() {
    setState(() {
      this.showDetails = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WorkoutBloc, WorkoutsState>(
      listener: (BuildContext context, WorkoutsState state) {},
      builder: (BuildContext context, WorkoutsState state) {
        if (!(state is CoursesDataLoaded) && state.props.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }

        return FutureBuilder(
          future: state.props.first,
          builder:
              (BuildContext context, AsyncSnapshot<List<Workout>> snapshot) {
            if ((snapshot.connectionState == ConnectionState.none ||
                    snapshot.connectionState == ConnectionState.waiting) ||
                snapshot.data == null) {
              if (snapshot.hasError) {
                // TODO: Add Crashlytics
                print(snapshot.error);
              }

              return Center(child: CircularProgressIndicator());
            }

            // if (showDetails && courseSelected != null) {
            //   return CourseDetails(
            //       course: courseSelected, callback: this.hideDetails);
            // }

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
                        ),
                        minFontSize: 26,
                        maxFontSize: 26,
                      ),
                    ),
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(8.0),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        // if (snapshot.data[index].courseDetail != null) {
                        //   return GestureDetector(
                        //       onTap: () {
                        //         setState(() {
                        //           courseSelected = snapshot.data[index];
                        //           showDetails = true;
                        //         });
                        //       },
                        //       child: CourseCard(
                        //         workout: snapshot.data[index],
                        //         color: colors[index % colors.length],
                        //         duration:
                        //             Duration(milliseconds: 400 * (index + 1)),
                        //       ));
                        // }

                        return CourseCard(
                          workout: snapshot.data[index],
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
