import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/blocs/workout/workout_bloc.dart';
import 'package:bfit_tracker/models/exercise.dart';
import 'package:bfit_tracker/models/workout.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:bfit_tracker/ui/home/workouts_area/workout_complete.dart';
import 'package:bfit_tracker/utils/coval_math.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WorkoutAction extends StatefulWidget {
  WorkoutAction({Key key}) : super(key: key);

  @override
  _WorkoutActionState createState() => _WorkoutActionState();
}

class _WorkoutActionState extends State<WorkoutAction> {
  // ignore: close_sinks
  WorkoutBloc workoutBloc;
  Workout workout;
  int currentExerciseIndex;
  Timer timer;
  double overallTime;
  double workoutTimer;
  bool paused;

  @override
  void initState() {
    super.initState();
    setState(() {
      workoutBloc = BlocProvider.of<WorkoutBloc>(context);
      workout = workoutBloc.state.props.first;
      currentExerciseIndex = 0;
      overallTime = 0.0;
      workoutTimer = 0.0;
      paused = false;
    });
  }

  @override
  void dispose() {
    this.workoutBloc?.close();
    this.timer?.cancel();
    super.dispose();
  }

  void createTimer(int seconds) {
    this.timer?.cancel();
    this.timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (!this.paused) {
        setState(() {
          overallTime++;
        });
        if (this.workoutTimer >= seconds) {
          this.timer.cancel();
          this.timer = null;
          if (this.currentExerciseIndex < this.workout.exercises.length) {
            this.workoutTimer = 0.0;
            setState(() {
              currentExerciseIndex++;
            });
          }
        } else {
          setState(() {
            workoutTimer++;
          });
        }
      }
    });
  }

  void pauseTimer() {
    setState(() {
      paused = !this.paused;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          ListView.separated(
            itemCount: this.workout.exercises.length,
            separatorBuilder: (BuildContext context, int index) => Divider(
              color: CustomColor.GREY_CHATEAU,
              thickness: 1,
              height: 1,
            ),
            itemBuilder: (BuildContext context, int index) {
              if (index == this.currentExerciseIndex) {
                int seconds = this.workout.exercises[index].seconds;
                if (this.timer == null) {
                  this.createTimer(seconds);
                }

                double percentage = this.workoutTimer / seconds;
                return exerciseTile(this.workout.exercises[index],
                    active: true, workoutProgress: percentage);
              }

              // We have therefore completed this exercise, let's show the 100% complete
              if (index < this.currentExerciseIndex) {
                return exerciseTile(this.workout.exercises[index],
                    active: false, completed: true, workoutProgress: 1);
              }

              return exerciseTile(this.workout.exercises[index]);
            },
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FloatingActionButton(
                  heroTag: 'paused',
                  onPressed: () => this.pauseTimer(),
                  backgroundColor: mainTheme.accentColor,
                  child: Icon(
                    this.paused ? Icons.play_arrow : Icons.pause,
                    color: Colors.white,
                  ),
                ),
                FloatingActionButton(
                  heroTag: 'continue',
                  onPressed: () {
                    print(this.overallTime);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            WorkoutComplete(this.workout, this.overallTime)));
                  },
                  disabledElevation: 0,
                  backgroundColor: mainTheme.primaryColor,
                  child: RotatedBox(
                    quarterTurns: 2,
                    child: SvgPicture.asset(
                      'assets/images/left-pointing-arrow.svg',
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget exerciseTile(Exercise exercise,
      {bool active = false,
      bool completed = false,
      double workoutProgress = 0.0}) {
    if (completed) {
      workoutProgress = 1;
    }

    return SizedBox(
      height: 64,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: <Widget>[
          FractionallySizedBox(
            widthFactor: workoutProgress,
            heightFactor: 1.0,
            child: Container(color: mainTheme.primaryColor.withOpacity(0.4)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 32.0),
                  child: AutoSizeText(
                    active
                        ? CovalMath.getHumanreadableTime(
                            this.workoutTimer.toInt())
                        : completed
                            ? CovalMath.getHumanreadableTime(exercise.seconds)
                            : '0:00',
                    maxFontSize: 12,
                    style: TextStyle(
                      color: CustomColor.DIM_GRAY,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                AutoSizeText(
                  exercise.name,
                  maxFontSize: 16,
                  style: TextStyle(
                    color: CustomColor.DIM_GRAY,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
