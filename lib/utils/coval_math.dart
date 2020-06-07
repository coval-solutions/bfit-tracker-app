import 'dart:math';

import 'package:intl/intl.dart';

/// Mathematics used specifically by Coval Solutions Ltd
class CovalMath {
  static final Random _random = Random();

  static String compact(value) {
    NumberFormat _compact = NumberFormat.compact();
    return _compact.format(value);
  }

  static double doubleInRange(int start, int end) =>
      _random.nextDouble() * (end - start) + start;
}
