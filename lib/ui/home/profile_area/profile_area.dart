import 'package:bfit_tracker/blocs/authentication/authentication_bloc.dart';
import 'package:bfit_tracker/blocs/fitness_data/fitness_data_bloc.dart';
import 'package:bfit_tracker/models/user_info.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:bfit_tracker/ui/custom.dart';
import 'package:bfit_tracker/ui/home/profile_area/profile_info.dart';
import 'package:bfit_tracker/ui/home/profile_area/stats_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health/health.dart';

class ProfileArea extends StatefulWidget {
  final UserInfo _userInfo;

  ProfileArea(this._userInfo);

  @override
  _ProfileAreaState createState() => _ProfileAreaState();
}

class _ProfileAreaState extends State<ProfileArea> {
  AuthenticationBloc _authenticationBloc;
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
    _fitnessDataBloc.close();
  }

  Future<void> _refresh() {
    if (_fitnessDataBloc == null) {
      _fitnessDataBloc = BlocProvider.of<FitnessDataBloc>(context);
      this._refresh();
    }

    if (!(_fitnessDataBloc.state is FitnessDataLoaded)) {
      _fitnessDataBloc.add(LoadFitnessData());
    }

    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EmptyAppBar(),
      backgroundColor: mainTheme.backgroundColor,
      body: BlocConsumer<FitnessDataBloc, FitnessDataState>(
        listener: (BuildContext context, state) {  },
        builder: (context, snapshot) {
          if (!(snapshot is FitnessDataLoaded)) {
            return Center(child: CircularProgressIndicator());
          }
          
          return FutureBuilder<Map<HealthDataType, Map>>(
              future: _fitnessDataBloc.state.props.first,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done || snapshot.data == null) {
                  return Center(child: CircularProgressIndicator());
                }

                var stepsData = snapshot.data.entries.where((item) => item.key == HealthDataType.STEPS);
                double todaysSteps = stepsData.first.value.values.last.value;
                double stepsPercent = (todaysSteps / widget._userInfo.goals.getSteps()) * 100;
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                  child: Column(
                    children: <Widget>[
                      profileInfo(_authenticationBloc.state.props.first),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 8,
                        ),
                      ),
                      Expanded(
                        child: noGlowListView(
                          <Widget>[
                            totalGymTimeStat(widget._userInfo.goals.getGym() / 100),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 6,
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                      child: otherStats(
                                          widget._userInfo.goals.getBmi(),
                                          'BMI Goal')),
                                ),
                                Expanded(
                                  child: Container(
                                      child: otherStats(
                                          widget._userInfo.goals.getWeight(),
                                          'Weight Goal',
                                          unit: 'kg')),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 6),
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                      child: otherStats(
                                          widget._userInfo.goals.getCourses(),
                                          'Course Total')),
                                ),
                                Expanded(
                                  child: Container(
                                      child:
                                          otherStats(stepsPercent, 'Daily Steps', unit: '%')),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              });
        },
      ),
    );
  }
}
