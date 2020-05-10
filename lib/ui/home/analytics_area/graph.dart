import 'package:bfit_tracker/theme.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:health/health.dart';

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
        .where((item) => item.key == HealthDataType.STEPS)
        .first
        .value
        .values
        .toList();

    List<FlSpot> flSpots = List<FlSpot>();
    rawStepsData.asMap().forEach((i, value) {
      flSpots.add(FlSpot(i.toDouble(), value.value.floorToDouble()));
    });

    if (rawStepsData.isEmpty) {
      return Container();
    }

    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(18),
                ),
                color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 18.0, left: 12.0, top: 24, bottom: 12),
              child: LineChart(
                mainData(flSpots),
              ),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData mainData(List<FlSpot> spots) {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        drawHorizontalLine: false,
      ),
      titlesData: FlTitlesData(
        show: false,
      ),
      borderData: FlBorderData(show: false),
      minX: 0,
      minY: 0,
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
