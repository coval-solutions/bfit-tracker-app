import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/blocs/workout/workout_bloc.dart';
import 'package:bfit_tracker/models/workout.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:bfit_tracker/ui/coval_solutions/empty_app_bar.dart';
import 'package:bfit_tracker/ui/home/workouts_area/workout_card.dart';
import 'package:bfit_tracker/ui/home/workouts_area/workout_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkoutsArea extends StatefulWidget {
  WorkoutsArea({Key key}) : super(key: key);

  @override
  _WorkoutsAreaState createState() => _WorkoutsAreaState();
}

class _WorkoutsAreaState extends State<WorkoutsArea> {
  final List<Color> colors = [mainTheme.primaryColor, mainTheme.accentColor];
  final TextEditingController textEditingController = TextEditingController();
  List<Workout> fastWorkouts = [];
  List<Workout> bodyWorkouts = [];

  @override
  void initState() {
    super.initState();
    textEditingController.addListener(filterResults);
  }

  void filterResults() {
    String text = textEditingController.text.toLowerCase();
    setState(() {
      fastWorkouts = fastWorkouts
          .where((element) =>
              element.title.toString().toLowerCase().contains(text))
          .toList();

      bodyWorkouts = bodyWorkouts
          .where((element) =>
              element.title.toString().toLowerCase().contains(text))
          .toList();
    });
  }

  @override
  void dispose() {
    this.textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkoutBloc, WorkoutsState>(
      builder: (BuildContext context, WorkoutsState state) {
        if (state is WorkoutsNotLoaded || state is WorkoutsLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (state is WorkoutSelected) {
          return WorkoutDetails(
            workout: state.props.first,
          );
        }

        List<Workout> workouts = state.props.first;

        // User hasn't searched anything, show all results (categorised)s
        if (this.textEditingController.text.isEmpty) {
          fastWorkouts =
              workouts.where((element) => element.isFast == true).toList();

          bodyWorkouts = workouts
              .where((element) => element.type.contains('body'))
              .toList();
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
                    ),
                    minFontSize: 26,
                    maxFontSize: 26,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: CupertinoTextField(
                    prefix: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        Icons.search,
                        color: CustomColor.DIM_GRAY,
                      ),
                    ),
                    placeholder: 'Search',
                    placeholderStyle: TextStyle(
                      height: 1.25,
                      color: CustomColor.DIM_GRAY,
                    ),
                    maxLines: 1,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    controller: this.textEditingController,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(14.0),
                      ),
                      border: Border.all(
                        color: CustomColor.DIM_GRAY,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 14),
                      child: AutoSizeText('FAST WORKOUTS'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 14),
                      child: AutoSizeText('Discover more >'),
                    ),
                  ],
                ),
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8.0),
                  itemCount: fastWorkouts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {
                          if (fastWorkouts[index].exercises.isNotEmpty) {
                            context.bloc<WorkoutBloc>()
                              ..add(SetWorkoutSelected(fastWorkouts[index]));
                          }
                        },
                        child: WorkoutCard(
                          smallTitle: fastWorkouts[index].type.toUpperCase(),
                          mainTitle: fastWorkouts[index].title,
                          description: fastWorkouts[index].description,
                          imageUrl: fastWorkouts[index].imageLocation,
                          color: colors[index % colors.length],
                          duration: Duration(milliseconds: 400 * (index + 1)),
                        ));
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 14),
                      child: AutoSizeText('BODY WORKOUTS'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 14),
                      child: AutoSizeText('Discover more >'),
                    ),
                  ],
                ),
                Container(
                  height: 164,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8.0),
                    itemCount: bodyWorkouts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                          onTap: () {
                            if (bodyWorkouts[index].exercises.isNotEmpty) {
                              context.bloc<WorkoutBloc>()
                                ..add(SetWorkoutSelected(bodyWorkouts[index]));
                            }
                          },
                          child: Container(
                            width: 230,
                            child: WorkoutCard(
                              smallTitle:
                                  "${bodyWorkouts[index].exercises.length} workouts",
                              mainTitle: bodyWorkouts[index].title,
                              description: bodyWorkouts[index].description,
                              imageUrl: bodyWorkouts[index].imageLocation,
                              color: colors[index % colors.length],
                              duration:
                                  Duration(milliseconds: 400 * (index + 1)),
                            ),
                          ));
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
