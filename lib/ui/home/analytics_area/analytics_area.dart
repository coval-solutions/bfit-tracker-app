import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/blocs/fitness_data/fitness_data_bloc.dart';
import 'package:bfit_tracker/repositories/fitness_data_repository.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:bfit_tracker/ui/home/analytics_area/stat_cards.dart';
import 'package:bfit_tracker/ui/home/analytics_area/weekdays_list.dart';
import 'package:bfit_tracker/ui/home/analytics_area/weekly_steps_graph.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health/health.dart';

class AnalyticsArea extends StatefulWidget {
  AnalyticsArea({Key key}) : super(key: key);

  @override
  _AnalyticsAreaState createState() => _AnalyticsAreaState();
}

class _AnalyticsAreaState extends State<AnalyticsArea> {
  FitnessDataBloc fitnessDataBloc;
  Map fitnessData;

  Map getStepsData(Map data) {
    try {
      return data.entries
          .firstWhere((element) => element.key == HealthDataType.STEPS)
          .value;
    } catch (error) {
      return null;
    }
  }

  void getFitnessData(Future future) {
    future.then((value) {
      setState(() {
        fitnessData = value;
      });
    });
  }

  Future<void> _refresh() {
    if (fitnessDataBloc != null) {
      fitnessDataBloc.add(LoadFitnessData());
    }

    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainTheme.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 6,
            vertical: 4,
          ),
          child: BlocConsumer<FitnessDataBloc, FitnessDataState>(
              listener: (context, state) {
            if (this.fitnessDataBloc == null) {
              this.setState(() {
                fitnessDataBloc = context.bloc();
              });
            }

            if (state is FitnessDataLoaded) {
              this.getFitnessData(state.props.first);
            }
          }, builder: (BuildContext context, FitnessDataState state) {
            if (!(state is FitnessDataLoaded) || this.fitnessData == null) {
              if (this.fitnessData == null && state.props.isNotEmpty) {
                this.getFitnessData(state.props.first);
              }

              return Center(child: CircularProgressIndicator());
            }

            return RefreshIndicator(
              onRefresh: this._refresh,
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topCenter,
                    child: AutoSizeText(
                      'Your Analytics',
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
                    padding: const EdgeInsets.symmetric(
                      vertical: 6,
                    ),
                  ),
                  WeekDayList(days: FitnessDataRepository.getDateTimes()),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 6,
                    ),
                  ),
                  StatsCardList(data: this.fitnessData),
                  Spacer(),
                  WeeklyStepsGraph(data: getStepsData(this.fitnessData)),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
