import 'package:bfit_tracker/blocs/workout/workout_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkoutAction extends StatefulWidget {
  WorkoutAction({Key key}) : super(key: key);

  @override
  _WorkoutActionState createState() => _WorkoutActionState();
}

class _WorkoutActionState extends State<WorkoutAction> {
  WorkoutBloc workoutBloc;

  @override
  void initState() {
    super.initState();
    workoutBloc = BlocProvider.of<WorkoutBloc>(context);
    print(this.workoutBloc.first);
  }

  @override
  void dispose() {
    this.workoutBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(this.workoutBloc.first);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(),
      // body: FutureBuilder(
      //   future: this.workoutBloc.first,
      //   builder: (BuildContext context, AsyncSnapshot<WorkoutsState> snapshot) {
      //     if (snapshot.connectionState != ConnectionState.done) {
      //       return CircularProgressIndicator();
      //     } else {
      //       return Text(snapshot.data.toString());
      //     }
      //   },
      // ),
    );
  }
}
