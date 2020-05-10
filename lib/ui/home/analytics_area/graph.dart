import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/blocs/fitness_data/fitness_data_bloc.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:health/health.dart';
import 'package:jiffy/jiffy.dart';

class LineChartSample2 extends StatefulWidget {
  final Map<HealthDataType, Map> data;

  const LineChartSample2({Key key, this.data}) : super(key: key);

  @override
  _LineChartSample2State createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> colors = [
    CustomColor.MAYA_BLUE.withOpacity(0.3),
    CustomColor.SELECTIVE_YELLOW.withOpacity(0.8),
  ];

  @override
  Widget build(BuildContext context) {
    var rawStepsData = widget.data.entries
      .where((item) => item.key == HealthDataType.STEPS);

    List<FlSpot> flSpots = List<FlSpot>();
    double maxSteps = 0;
    rawStepsData.first.value.values.toList().asMap().forEach((i, value) {
      value = value.value.round().toDouble();
      if (value > maxSteps) {
        maxSteps = value;
      }

      flSpots.add(FlSpot(i.toDouble(), value));
    });

    if (rawStepsData.isEmpty) {
      return Container();
    }

    List<String> dateTimes = widget.data.entries.first.value.keys.toList();

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
                  style: TextStyle(
                    color: CustomColor.DIM_GRAY),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 12,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: LineChart(
                      mainData(flSpots, maxSteps, dateTimes),
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

  LineChartData mainData(List<FlSpot> spots, double maxSteps, List<String> dates) {
    print(maxSteps);
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: CustomColor.MAYA_BLUE.withOpacity(0.3),
          getTooltipItems: customLineTooltipItem,
          tooltipPadding: EdgeInsets.all(4),
        )
      ),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        drawHorizontalLine: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          textStyle:
              const TextStyle(color: CustomColor.DIM_GRAY, fontWeight: FontWeight.bold, fontSize: 12),
          getTitles: (value) {
            return Jiffy(dates[value.toInt()]).E; 
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          interval: (maxSteps / (FitnessDataBloc.numOfDaysInThePast + 1)).round().toDouble(),
          showTitles: true,
          textStyle: const TextStyle(
            color: CustomColor.DIM_GRAY,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          getTitles: (value) {
            return value.toStringAsFixed(0).toString();
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