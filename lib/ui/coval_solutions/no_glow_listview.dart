import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class NoGlowingOverscrollIndicator extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
