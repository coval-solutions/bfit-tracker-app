import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EmptyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  Size get preferredSize => Size(0.0, 12.0);
}

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

/// Mathematics used specifically by Coval Solutions Ltd
class CovalMath {
  static String compact(value) {
    NumberFormat _compact = NumberFormat.compact();
    return _compact.format(value);
  }
}
