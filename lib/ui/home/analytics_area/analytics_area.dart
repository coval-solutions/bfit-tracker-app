import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:bfit_tracker/ui/home/analytics_area/graph.dart';
import 'package:bfit_tracker/ui/home/analytics_area/stat_cards.dart';
import 'package:bfit_tracker/ui/home/analytics_area/weekdays_list.dart';
import 'package:flutter/material.dart';
import 'package:bfit_tracker/ui/custom.dart';

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
            WeekDayList(),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 6,
              ),
            ),
            StatCards(),
            Spacer(),
            LineChartSample2(),
          ],
        ),
      ),
    );
  }
}
