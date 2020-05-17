import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/blocs/fitness_data/fitness_data_bloc.dart';
import 'package:bfit_tracker/models/fitness_stat.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:bfit_tracker/ui/custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health/health.dart';

class StatsCardList extends StatefulWidget {
  final Map<HealthDataType, Map> data;

  const StatsCardList({Key key, @required this.data}) : super(key: key);

  @override
  _StatsCardListState createState() => _StatsCardListState();
}

class _StatsCardListState extends State<StatsCardList> {
  //ignore: close_sinks
  FitnessDataBloc fitnessDataBloc;
  List<FitnessStat> fitnessStats;
  List<Color> colors;

  @override
  void initState() {
    super.initState();
    colors = [CustomColor.SELECTIVE_YELLOW, CustomColor.MAYA_BLUE];
    fitnessDataBloc = BlocProvider.of<FitnessDataBloc>(context);
  }

  void setFitnessDataForDate(DateTime dateTime) {
    List<FitnessStat> fitnessData = List<FitnessStat>();
    widget.data.entries.forEach((element) {
      try {
        var healthTypeForDate = element.value.entries
            .firstWhere((element) => element.key == dateTime);

        if (healthTypeForDate != null) {
          fitnessData.add(healthTypeForDate.value);
        }
      } catch (error) {}
    });

    setState(() {
      this.fitnessStats = fitnessData;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data == null) {
      return Center(child: CircularProgressIndicator());
    }

    if (fitnessDataBloc != null) {
      this.setFitnessDataForDate(fitnessDataBloc.state.props.last);
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: 1,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 190,
          child: ListView.builder(
            itemCount: fitnessStats != null ? fitnessStats.length : 0,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return StatCard(
                  fitnessStat: fitnessStats[index],
                  color: this.colors[index % this.colors.length]);
            },
          ),
        );
      },
    );
  }
}

class StatCard extends StatelessWidget {
  final FitnessStat fitnessStat;
  final Color color;

  const StatCard(
      {Key key,
      @required this.fitnessStat,
      this.color = CustomColor.SELECTIVE_YELLOW})
      : super(key: key);

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
                  this.fitnessStat.getHumanReadableType(),
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
                      text: this.fitnessStat.getHumanReadableValue(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: this.fitnessStat.getUnits(),
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
