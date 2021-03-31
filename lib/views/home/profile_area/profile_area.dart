import 'package:bfit_tracker/blocs/authentication/authentication_bloc.dart';
import 'package:bfit_tracker/blocs/fitness_data/fitness_data_bloc.dart';
import 'package:bfit_tracker/models/user_info.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:bfit_tracker/views/home/profile_area/profile_info.dart';
import 'package:bfit_tracker/views/home/profile_area/stats_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health/health.dart';
import 'package:recase/recase.dart';

class ProfileArea extends StatefulWidget {
  final UserInfo _userInfo;

  ProfileArea(this._userInfo);

  @override
  _ProfileAreaState createState() => _ProfileAreaState();
}

class _ProfileAreaState extends State<ProfileArea> {
  AuthenticationBloc _authenticationBloc;
  //ignore: close_sinks
  FitnessDataBloc _fitnessDataBloc;

  @override
  void initState() {
    super.initState();
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    _fitnessDataBloc = BlocProvider.of<FitnessDataBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
    _authenticationBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainTheme.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 12),
          child: SingleChildScrollView(
            child: BlocConsumer<FitnessDataBloc, FitnessDataState>(
              listener: (BuildContext context, state) {},
              builder: (context, snapshot) {
                if (!(snapshot is FitnessDataLoaded)) {
                  return Center(child: CircularProgressIndicator());
                }

                var stats = this.widget._userInfo.getStats().entries;
                return FutureBuilder<Map<HealthDataType, Map>>(
                    future: _fitnessDataBloc.state.props.first,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done ||
                          snapshot.data == null) {
                        return Center(child: CircularProgressIndicator());
                      }

                      var stepsData = snapshot.data.entries
                          .where((item) => item.key == HealthDataType.STEPS);
                      double todaysSteps =
                          double.parse(stepsData.first.value.values.last.value);
                      double stepsPercent =
                          (todaysSteps / widget._userInfo.goals.getSteps()) *
                              100;
                      return Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                        child: Column(
                          children: <Widget>[
                            profileInfo(_authenticationBloc.state.props.first),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 8,
                              ),
                            ),
                            totalGymTimeStat(widget._userInfo.gymTime /
                                widget._userInfo.goals.getGym()),
                            GridView.builder(
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                itemCount: stats.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2),
                                itemBuilder: (BuildContext context, int index) {
                                  var element = stats.elementAt(index);
                                  // Don't title case this, otherwise BMI appears like: B M I
                                  if (element.key == 'BMI Goal') {
                                    double currentBmi =
                                        this.widget._userInfo.calculateBmi();
                                    return otherStats(
                                      (currentBmi / element.value) * 100,
                                      'BMI Goal\nProgress',
                                      unit: '%',
                                    );
                                  }

                                  if (element.key == 'Daily Steps') {
                                    return otherStats(
                                        stepsPercent, 'Daily Steps\nProgress',
                                        unit: '%');
                                  }

                                  if (element.key == 'Weight Goal') {
                                    int currentWeight =
                                        this.widget._userInfo.weight;
                                    return otherStats(
                                        (currentWeight / element.value) * 100,
                                        'Weight Goal\nProgress',
                                        unit: '%');
                                  }

                                  if (element.key == 'Workouts Total') {
                                    int totalWorkoutsComplete = this
                                        .widget
                                        ._userInfo
                                        .totalWorkoutsCompleted;
                                    return otherStats(
                                        (totalWorkoutsComplete /
                                                element.value) *
                                            100,
                                        'Workouts Complete\nProgress',
                                        unit: '%');
                                  }

                                  return otherStats(
                                      element.value, element.key.titleCase);
                                }),
                          ],
                        ),
                      );
                    });
              },
            ),
          ),
        ),
      ),
    );
  }
}
