import 'dart:math';

import 'package:bfit_tracker/utils.dart';
import 'package:intl/intl.dart';

/// Mathematics used specifically by Coval Solutions Ltd
class CovalMath {
  static final Random _random = Random();
  static final String _localeString = Utils.locale();

  static String compact(value) {
    NumberFormat _compact = NumberFormat.compact(locale: _localeString);
    return _compact.format(value);
  }

  static String decimal(value) {
    return NumberFormat.decimalPattern(_localeString).format(value);
  }

  static String fillZero(value, position) {
    return value.toString().padLeft(position, '0');
  }

  static String getHumanreadableTime(int seconds) {
    if (seconds == 0) {
      return '0:00';
    }

    var duration = Duration(seconds: seconds);
    int remainderSecs = duration.inSeconds.remainder(60);
    if (remainderSecs > 0) {
      return '${duration.inMinutes.remainder(60)}:${CovalMath.fillZero(remainderSecs, 2)}';
    }

    return '${CovalMath.fillZero(duration.inMinutes.remainder(60), 2)}';
  }

  static double doubleInRange(int start, int end) =>
      _random.nextDouble() * (end - start) + start;
}
