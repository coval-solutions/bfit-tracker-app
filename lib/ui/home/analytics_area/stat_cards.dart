import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/blocs/fitness_data/fitness_data_bloc.dart';
import 'package:bfit_tracker/models/fitness_stat.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health/health.dart';

class StatCards extends StatefulWidget {
  StatCards({Key key}) : super(key: key);

  @override
  _StatCardsState createState() => _StatCardsState();
}

class _StatCardsState extends State<StatCards> {
  FitnessDataBloc fitnessDataBloc;

  @override
  void initState() {
    super.initState();
    fitnessDataBloc = BlocProvider.of<FitnessDataBloc>(context);
  }

  Future<void> _refresh() {
    if (fitnessDataBloc == null) {
      fitnessDataBloc = BlocProvider.of<FitnessDataBloc>(context);
      this._refresh();
    }

    if (!(fitnessDataBloc.state is FitnessDataLoaded)) {
      fitnessDataBloc.add(LoadFitnessData());
    }

    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<HealthDataType, Map>>(
        future: this.fitnessDataBloc.state.props.first,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            String dateSelected = fitnessDataBloc.state.props.last.toString();
            return RefreshIndicator(
              onRefresh: this._refresh,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  var data = snapshot.data.entries;
                  bool useBlue = false;
                  return Container(
                    height: 190,
                    child: ListView.builder(
                      itemCount: data.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        var fitnessStats = data.elementAt(index).value;
                        if (fitnessStats.containsKey(dateSelected)) {
                          FitnessStat fitnessStat = fitnessStats[dateSelected];
                          if (fitnessStat.type ==
                              HealthDataType.BLOOD_PRESSURE_SYSTOLIC) {
                            Map<String, FitnessStat> bloodPressureDiastolicMap =
                                data
                                    .firstWhere((type) =>
                                        type.key ==
                                        HealthDataType.BLOOD_PRESSURE_DIASTOLIC)
                                    .value;

                            FitnessStat bloodPressureDiastolic =
                                bloodPressureDiastolicMap.entries
                                    .firstWhere(
                                        (item) => item.key == dateSelected)
                                    .value;

                            useBlue = !useBlue;
                            return _StatCard(
                              title: fitnessStat.getHumanReadableType(),
                              value:
                                  "${fitnessStat.value.toStringAsFixed(0)}/${bloodPressureDiastolic.value.toStringAsFixed(0)}",
                              unit: fitnessStat.getUnits(),
                              color: useBlue
                                  ? CustomColor.MAYA_BLUE
                                  : CustomColor.SELECTIVE_YELLOW,
                            );
                          } else if (fitnessStat.type ==
                              HealthDataType.BLOOD_PRESSURE_DIASTOLIC) {
                            return Container();
                          }

                          if (fitnessStat.type == HealthDataType.STEPS) {
                            useBlue = !useBlue;
                            return _StatCard(
                              title: fitnessStat.getHumanReadableType(),
                              value: fitnessStat.value.toStringAsFixed(0),
                              unit: fitnessStat.getUnits(),
                              color: useBlue
                                  ? CustomColor.MAYA_BLUE
                                  : CustomColor.SELECTIVE_YELLOW,
                            );
                          }

                          useBlue = !useBlue;
                          return _StatCard(
                            title: fitnessStat.getHumanReadableType(),
                            value: fitnessStat.value.toString(),
                            unit: fitnessStat.getUnits(),
                            color: useBlue
                                ? CustomColor.MAYA_BLUE
                                : CustomColor.SELECTIVE_YELLOW,
                          );
                        }

                        return Container();
                      },
                    ),
                  );
                },
              ),
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard(
      {Key key, this.title = '', this.value = '', this.unit = '', this.color})
      : super(key: key);

  final String title;
  final String value;
  final String unit;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 6,
      ),
      child: Container(
        width: 166,
        child: Card(
          elevation: 2,
          color: this.color ?? mainTheme.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 40, left: 14, right: 14),
                child: AutoSizeText(
                  this.title,
                  minFontSize: 20,
                  maxLines: 2,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(
                  left: 14,
                  bottom: 14,
                ),
                child: AutoSizeText.rich(
                    TextSpan(
                      text: this.value,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: this.unit,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                    maxLines: 1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
