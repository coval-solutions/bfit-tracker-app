import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/blocs/workout/workout_bloc.dart';
import 'package:bfit_tracker/models/workout.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:bfit_tracker/ui/coval_solutions/back_arrow.dart';
import 'package:bfit_tracker/ui/coval_solutions/no_glow_listview.dart';
import 'package:bfit_tracker/ui/home/workouts_area/equipment_pill.dart';
import 'package:bfit_tracker/ui/home/workouts_area/exercise_list_item.dart';
import 'package:bfit_tracker/ui/home/workouts_area/workout_countdown.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recase/recase.dart';

class WorkoutDetails extends StatefulWidget {
  final Workout workout;

  const WorkoutDetails({@required this.workout, Key key}) : super(key: key);

  @override
  _WorkoutDetailsState createState() => _WorkoutDetailsState();
}

class _WorkoutDetailsState extends State<WorkoutDetails> {
  List<Color> colors;

  @override
  void initState() {
    super.initState();
    colors = [mainTheme.primaryColor, mainTheme.accentColor];
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
    if (this.widget.workout.exercises == null ||
        this.widget.workout.exercises.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    var equipment = this.widget.workout.getEquipment();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<WorkoutBloc>(context)..add(LoadWorkouts());
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 28.0, left: 12.0),
                    child: BackArrow(
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
                        fontWeight: FontWeight.w600,
                        color: CustomColor.DIM_GRAY),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 18.0, left: 12.0),
                  child: AutoSizeText(
                    widget.workout.title,
                    minFontSize: 26,
                    maxFontSize: 36,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: CustomColor.DIM_GRAY),
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
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Icon(
                                Icons.directions_run,
                                color: CustomColor.DIM_GRAY,
                              ),
                            ),
                            AutoSizeText(
                              '${widget.workout.exercises?.length} exercises',
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
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Icon(
                                Icons.timer,
                                color: CustomColor.DIM_GRAY,
                              ),
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
                SizedBox(height: 16),
                Expanded(
                  child: Card(
                    elevation: 0,
                    color: mainTheme.backgroundColor,
                    margin: EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            AutoSizeText(
                              'Equipment',
                              minFontSize: 16,
                              maxFontSize: 24,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: CustomColor.DIM_GRAY,
                              ),
                            ),
                            SizedBox(height: 16),
                            Container(
                              height: 32,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                physics: AlwaysScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: equipment.length,
                                itemBuilder: (context, i) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: EquipmentPill(
                                      pillColor: CustomColor.GREY_CHATEAU
                                          .withOpacity(0.4),
                                      borderColor: mainTheme.backgroundColor,
                                      textColor: CustomColor.DIM_GRAY,
                                      equipment: equipment[i],
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 16),
                            AutoSizeText(
                              'Exercises',
                              minFontSize: 16,
                              maxFontSize: 24,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: CustomColor.DIM_GRAY,
                              ),
                            ),
                            SizedBox(height: 16),
                            Expanded(
                              child: ScrollConfiguration(
                                behavior: NoGlowingOverscrollIndicator(),
                                child: ListView.separated(
                                  padding: EdgeInsets.only(bottom: 52),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount:
                                      widget.workout.exercises?.length ?? 0,
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          Divider(),
                                  itemBuilder: (context, index) {
                                    return ExerciseListItem(
                                      exercise: widget.workout.exercises[index],
                                      color: this
                                          .colors[index % this.colors.length],
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 18,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: CupertinoButton(
                  color: mainTheme.accentColor,
                  pressedOpacity: 0.8,
                  onPressed: () {
                    String eventName =
                        'workout_${widget.workout.docRef}_started';
                    FirebaseAnalytics().logEvent(name: eventName);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            WorkoutCountdown(number: 5)));
                  },
                  child: AutoSizeText(
                    'Start Now',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    minFontSize: 18,
                    maxLines: 1,
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 6,
                      color: Colors.grey.shade300,
                      offset: Offset(0, 0.75),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
