import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:bfit_tracker/ui/home/workouts_area/workout_action.dart';
import 'package:flutter/material.dart';

class WorkoutCountdown extends StatefulWidget {
  final int number;

  WorkoutCountdown({Key key, @required this.number}) : super(key: key);

  @override
  _WorkoutCountdownState createState() => _WorkoutCountdownState();
}

class Countdown extends AnimatedWidget {
  final Animation<int> animation;

  Countdown({Key key, this.animation}) : super(key: key, listenable: animation);

  @override
  build(BuildContext context) {
    return Text(
      'GO!',
      style: TextStyle(fontSize: 150.0, color: Colors.white),
    );
  }
}

class _WorkoutCountdownState extends State<WorkoutCountdown>
    with TickerProviderStateMixin {
  List<int> numberList;
  AnimationController controller;
  Timer timer;

  @override
  void initState() {
    super.initState();
    numberList =
        List<int>.generate(widget.number, (i) => i + 1).reversed.toList();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => countdown());
  }

  countdown() {
    if (this.numberList.isEmpty) {
      // Force re-build, so animation is then shown
      setState(() {
        this.numberList = [];
      });
      controller.forward().whenComplete(() => {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => WorkoutAction()))
          });
      timer.cancel();
    } else {
      this.numberList.removeAt(0);
      setState(() {
        this.numberList = this.numberList;
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    controller?.stop();
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.NIGHT_RIDER,
      body: Center(
        child: this.controller.isAnimating
            ? Countdown(
                animation: StepTween(
                  begin: 0,
                  end: 0,
                ).animate(this.controller),
              )
            : ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: this.numberList.length,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      AutoSizeText(
                        this.numberList[index].toString(),
                        minFontSize:
                            double.parse((64 / (index + 1)).toStringAsFixed(0)),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color:
                              Colors.white.withOpacity(index == 0 ? 1 : 0.45),
                        ),
                      )
                    ],
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 4);
                },
              ),
      ),
    );
  }
}
