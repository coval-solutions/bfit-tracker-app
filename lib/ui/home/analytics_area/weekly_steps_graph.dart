import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/blocs/fitness_data/fitness_data_bloc.dart';
import 'package:bfit_tracker/models/fitness_stat.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:bfit_tracker/ui/custom.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class WeeklyStepsGraph extends StatefulWidget {
  final Map data;

  const WeeklyStepsGraph({Key key, @required this.data}) : super(key: key);

  @override
  _WeeklyStepsGraphState createState() => _WeeklyStepsGraphState();
}

class _WeeklyStepsGraphState extends State<WeeklyStepsGraph> {
  List<Color> colors = [
    mainTheme.accentColor.withOpacity(0.3),
    mainTheme.primaryColor.withOpacity(0.8),
  ];

  @override
  Widget build(BuildContext context) {
    List<FlSpot> flSpots = List<FlSpot>();
    double index = 0.0;
    double maxSteps = 0;
    widget.data.forEach((key, value) {
      FitnessStat fitnessStat = value;
      value = double.parse(fitnessStat.value);
      if (value > maxSteps) {
        maxSteps = value;
      }

      flSpots.add(FlSpot(index, value));
      index++;
    });

    return AspectRatio(
      aspectRatio: 1.7,
      child: Container(
        decoration: BoxDecoration(
          color: CustomColor.GREY_CHATEAU.withOpacity(0.12),
          borderRadius: const BorderRadius.all(Radius.circular(18)),
        ),
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 12,
                ),
                AutoSizeText(
                  'Weekly Steps',
                  minFontSize: 22,
                  style: TextStyle(color: CustomColor.DIM_GRAY),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 36,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: LineChart(
                      mainData(flSpots, maxSteps, widget.data.keys.toList()),
                      swapAnimationDuration: const Duration(milliseconds: 250),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  LineChartData mainData(
      List<FlSpot> spots, double maxSteps, List<DateTime> dates) {
    return LineChartData(
      lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
        tooltipBgColor: mainTheme.accentColor.withOpacity(0.3),
        getTooltipItems: customLineTooltipItem,
        tooltipPadding: EdgeInsets.all(4),
      )),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        drawHorizontalLine: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          textStyle: const TextStyle(
              color: CustomColor.DIM_GRAY,
              fontWeight: FontWeight.bold,
              fontSize: 12),
          getTitles: (value) {
            return Jiffy(dates[value.toInt()]).E;
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          interval: (maxSteps / (FitnessDataBloc.numOfDaysInThePast + 1))
              .round()
              .toDouble(),
          showTitles: true,
          textStyle: const TextStyle(
            color: CustomColor.DIM_GRAY,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          getTitles: (value) {
            return CovalMath.compact(value);
          },
          reservedSize: 30,
          margin: 8,
        ),
      ),
      borderData: FlBorderData(show: false),
      minX: 0,
      minY: 0,
      maxX: FitnessDataBloc.numOfDaysInThePast.toDouble(),
      maxY: maxSteps,
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          colors: [colors.last],
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors: [colors.first],
          ),
        ),
      ],
    );
  }
}

List<LineTooltipItem> customLineTooltipItem(List<LineBarSpot> touchedSpots) {
  if (touchedSpots == null) {
    return null;
  }

  return touchedSpots.map((LineBarSpot touchedSpot) {
    if (touchedSpot == null) {
      return null;
    }
    final TextStyle textStyle = TextStyle(
      color: touchedSpot.bar.colors[0],
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    return LineTooltipItem(touchedSpot.y.toInt().toString(), textStyle);
  }).toList();
}
