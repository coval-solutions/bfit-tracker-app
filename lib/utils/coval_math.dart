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

  static double doubleInRange(int start, int end) =>
      _random.nextDouble() * (end - start) + start;
}
