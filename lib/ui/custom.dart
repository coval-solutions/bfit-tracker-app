import 'package:flutter/material.dart';

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
    behavior: __NoGlowingOverscrollIndicator(),
    child: ListView(
      shrinkWrap: true,
      children: children,
    ),
  );
}

class __NoGlowingOverscrollIndicator extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}