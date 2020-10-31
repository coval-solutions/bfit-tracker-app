import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

Widget totalGymTimeStat(gymTime) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    color: Colors.white,
    child: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              left: 5,
            ),
            child: AutoSizeText(
              'Total Gym Time',
              maxLines: 1,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: CustomColor.GREY_CHATEAU,
                fontSize: 14,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 6,
            ),
          ),
          LinearPercentIndicator(
            animation: true,
            lineHeight: 10.0,
            percent: gymTime,
            backgroundColor: CustomColor.LAVENDER,
            progressColor: CustomColor.SELECTIVE_YELLOW,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 4,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget otherStats(value, text, {unit}) {
  double value100 = (value / 100);
  bool overMax = value100 > 1;

  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    color: Colors.white,
    child: CircularPercentIndicator(
      animation: true,
      radius: 120.0,
      lineWidth: 6,
      percent: overMax ? min(1, value100 - 1) : value100,
      circularStrokeCap: CircularStrokeCap.round,
      center: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AutoSizeText.rich(
              TextSpan(
                text: value.toStringAsFixed(0),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: CustomColor.DIM_GRAY,
                  fontSize: 18,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: unit?.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: CustomColor.DIM_GRAY,
                      fontSize: 8,
                    ),
                  ),
                ],
              ),
              maxLines: 1),
          Padding(
            padding: EdgeInsets.only(
              bottom: 4,
            ),
          ),
          AutoSizeText(
            text.toString(),
            maxLines: 1,
            style: TextStyle(
              color: CustomColor.DIM_GRAY,
              fontSize: 12,
            ),
          ),
        ],
      ),
      backgroundColor: overMax ? mainTheme.accentColor : CustomColor.LAVENDER,
      progressColor: overMax ? mainTheme.primaryColor : mainTheme.accentColor,
    ),
  );
}
