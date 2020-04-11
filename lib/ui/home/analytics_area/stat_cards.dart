import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/blocs/fitness_data/fitness_data_bloc.dart';
import 'package:bfit_tracker/models/stats.dart';
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

  Future<void> _refresh() {
    if (fitnessDataBloc == null) {
      fitnessDataBloc = BlocProvider.of<FitnessDataBloc>(context);
      this._refresh();
    }

    fitnessDataBloc.add(LoadFitnessData(fitnessDataBloc.state.props.last));
    return Future.value();
  }

  @override
  void dispose() {
    super.dispose();
    fitnessDataBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FitnessDataBloc, FitnessDataState>(
      builder: (BuildContext context, FitnessDataState state) {
        if (!(state is FitnessDataLoaded)) {
          return Center(child: CircularProgressIndicator());
        }

        return FutureBuilder<Stats>(
            future: state.props.first,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return RefreshIndicator(
                  onRefresh: this._refresh,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: 1,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 190,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            if (snapshot.data.heartRate > 0) 
                              _StatCard(
                                title: Stats.HEART_RATE_NAME,
                                value: snapshot.data.heartRate.toString(),
                                unit: Stats.HEART_RATE_UNIT,
                              ),
                            _StatCard(
                              title: Stats.STEPS_NAME,
                              value: snapshot.data.steps.toInt().toString(),
                              unit: Stats.STEPS_UNIT,
                              color: CustomColor.MAYA_BLUE,
                            ),
                            _StatCard(
                              title: Stats.WORKOUTS_COMPLETE_NAME,
                              value: '30',
                            ),
                            if (snapshot.data.bloodPressureSystolic > 0 && snapshot.data.bloodPressureDiastolic > 0) 
                              _StatCard(
                                title: Stats.BLOOD_PRESSURE_NAME,
                                value:
                                    "${snapshot.data.bloodPressureSystolic.toInt()}/${snapshot.data.bloodPressureDiastolic.toInt()}",
                                color: CustomColor.MAYA_BLUE,
                              ),
                            if (snapshot.data.bodyTemperature > 0) 
                              _StatCard(
                                title: Stats.BODY_TEMPERATURE_NAME,
                                value: snapshot.data.bodyTemperature.toString(),
                                unit: Stats.CELSIUS_UNIT,
                              ),
                            _StatCard(
                              title: Stats.ACTIVE_ENERGY_BURNED_RATE_NAME,
                              value: snapshot.data.activeEnergyBurned.toString(),
                              color: CustomColor.MAYA_BLUE,
                              unit: Stats.CALORIES_UNIT,
                            ),
                          ],
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
      },
    );
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
                padding: const EdgeInsets.only(
                  top: 40,
                  left: 14,
                  right: 14
                ),
                child: AutoSizeText(
                  this.title,
                  minFontSize: 22,
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
