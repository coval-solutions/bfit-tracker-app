import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

Widget noGlowListView(List<Widget> children) {
  return ScrollConfiguration(
    behavior: NoGlowingOverscrollIndicator(),
    child: ListView(
      shrinkWrap: true,
      children: children,
      physics: const AlwaysScrollableScrollPhysics(),
    ),
  );
}

class NoGlowingOverscrollIndicator extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
