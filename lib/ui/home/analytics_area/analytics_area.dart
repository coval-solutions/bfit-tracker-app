import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/blocs/fitness_data/fitness_data_bloc.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:bfit_tracker/ui/home/analytics_area/graph.dart';
import 'package:bfit_tracker/ui/home/analytics_area/stat_cards.dart';
import 'package:bfit_tracker/ui/home/analytics_area/weekdays_list.dart';
import 'package:flutter/material.dart';
import 'package:bfit_tracker/ui/custom.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health/health.dart';

class AnalyticsArea extends StatefulWidget {
  AnalyticsArea({Key key}) : super(key: key);

  @override
  _AnalyticsAreaState createState() => _AnalyticsAreaState();
}

class _AnalyticsAreaState extends State<AnalyticsArea> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EmptyAppBar(),
      backgroundColor: mainTheme.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 6,
          vertical: 4,
        ),
        child: BlocConsumer<FitnessDataBloc, FitnessDataState>(
            listener: (context, state) {},
            builder: (BuildContext context, FitnessDataState state) {
              if (!(state is FitnessDataLoaded)) {
                return Center(child: CircularProgressIndicator());
              }

              return FutureBuilder<Map<HealthDataType, Map>>(
                  future: state.props.first,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.data != null) {
                      return Column(children: <Widget>[
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
                        WeekDayList(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 6,
                          ),
                        ),
                        StatCards(),
                        Spacer(),
                        LineChartSample2(data: snapshot.data)
                      ]);
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  });
            }),
      ),
    );
  }
}
