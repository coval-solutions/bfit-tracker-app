import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/blocs/workout/workout_bloc.dart';
import 'package:bfit_tracker/controllers/workout_controller.dart';
import 'package:bfit_tracker/models/workout.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:bfit_tracker/ui/home/workouts_area/workouts_area.dart';
import 'package:bfit_tracker/utils/coval_math.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:transformer_page_view/transformer_page_view.dart';

class WorkoutComplete extends StatefulWidget {
  final Workout workout;
  final double secondsWorkingOut;

  WorkoutComplete(this.workout, this.secondsWorkingOut);

  @override
  _WorkoutCompleteState createState() => _WorkoutCompleteState();
}

class _WorkoutCompleteState extends State<WorkoutComplete> {
  static const NUM_OF_PAGES = 2;
  TransformerPageController _pageController;
  Future _fetchWorkoutStartedCountFuture;
  Bloc _workoutBloc;

  @override
  void initState() {
    super.initState();
    _pageController = TransformerPageController();
    _fetchWorkoutStartedCountFuture =
        WorkoutController.fetchWorkoutStartedCount(widget.workout.docRef);
    _workoutBloc = BlocProvider.of<WorkoutBloc>(context);
  }

  @override
  void dispose() {
    _workoutBloc..add(LoadWorkouts());
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: SvgPicture.asset(
                  'assets/images/workout_complete_background.svg',
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: AutoSizeText(
                  'Great job!',
                  minFontSize: 20,
                  maxFontSize: 26,
                  style: TextStyle(
                    color: mainTheme.accentColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: AutoSizeText(
                  widget.workout.title + '\ncompleted',
                  minFontSize: 26,
                  maxFontSize: 36,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: CustomColor.DIM_GRAY,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(bottom: 60),
                  child: Container(
                    height: 64,
                    child: TransformerPageView(
                        pageSnapping: true,
                        loop: false,
                        pageController: _pageController,
                        itemCount: NUM_OF_PAGES,
                        transformer: PageTransformerBuilder(
                            builder: (Widget child, TransformInfo info) {
                          if (info.index == 0) {
                            return workoutCompleteResults(
                                widget.workout, widget.secondsWorkingOut);
                          }

                          return workoutCompleteNumberOfTimes(
                              widget.workout,
                              widget.secondsWorkingOut,
                              this._fetchWorkoutStartedCountFuture);
                        })),
                  )),
              Container(
                child: CupertinoButton(
                  color: mainTheme.accentColor,
                  onPressed: () {},
                  child: AutoSizeText(
                    'SHARE YOUR RESULTS',
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: CupertinoButton(
                  onPressed: () {
                    // TODO: Send results of this workout over to Firestore
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => WorkoutsArea()));
                  },
                  child: AutoSizeText(
                    'CONTINUE',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: CustomColor.DIM_GRAY,
                    ),
                    minFontSize: 16,
                    maxLines: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget workoutCompleteResults(Workout workout, double secondsWorkingOut) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      AutoSizeText.rich(
        TextSpan(
          text: workout.exercises.length.toString(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: CustomColor.DIM_GRAY,
          ),
          children: <TextSpan>[
            TextSpan(
              text: '\nExercises',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 8,
              ),
            ),
          ],
        ),
        textAlign: TextAlign.center,
        minFontSize: 22,
        maxFontSize: 26,
      ),
      SizedBox(
        width: 1,
        height: 36,
        child: Container(
          color: CustomColor.GREY_CHATEAU,
        ),
      ),
      AutoSizeText.rich(
        TextSpan(
          text: CovalMath.getHumanreadableTime(secondsWorkingOut.toInt()),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: CustomColor.DIM_GRAY,
          ),
          children: <TextSpan>[
            TextSpan(
              text: '\nMinutes',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 8,
              ),
            ),
          ],
        ),
        textAlign: TextAlign.center,
        minFontSize: 22,
        maxFontSize: 26,
      ),
      SizedBox(
        width: 1,
        height: 36,
        child: Container(
          color: CustomColor.GREY_CHATEAU,
        ),
      ),
      AutoSizeText.rich(
        TextSpan(
          text: (secondsWorkingOut * 0.15).floor().toString(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: CustomColor.DIM_GRAY,
          ),
          children: <TextSpan>[
            TextSpan(
              text: '\nCalories',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 8,
              ),
            ),
          ],
        ),
        textAlign: TextAlign.center,
        minFontSize: 22,
        maxFontSize: 26,
      ),
    ],
  );
}

Widget workoutCompleteNumberOfTimes(
    Workout workout, double secondsWorkingOut, Future future) {
  return FutureBuilder(
      future: future,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.connectionState == ConnectionState.none) {
          return Center(child: CircularProgressIndicator());
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AutoSizeText.rich(
              TextSpan(
                text: snapshot.hasData ? snapshot.data.toString() : '0',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: CustomColor.DIM_GRAY,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text:
                        '\ntimes this training was completed by\npeople all over the universe',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 8,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
              minFontSize: 22,
              maxFontSize: 26,
            ),
          ],
        );
      });
}
