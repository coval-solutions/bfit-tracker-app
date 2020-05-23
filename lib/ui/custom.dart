import 'package:auto_size_text/auto_size_text.dart';
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

class AnimatedCount extends AnimatedWidget {
  final Animation<int> animation;
  final TextStyle textStyle;

  const AnimatedCount(
      {@required this.animation, @required this.textStyle, Key key})
      : super(key: key, listenable: animation);

  @override
  build(BuildContext context) {
    return AutoSizeText(
      animation.value.toString(),
      style: textStyle,
    );
  }
}

/// Mathematics used specifically by Coval Solutions Ltd
class CovalMath {
  static String compact(value) {
    NumberFormat _compact = NumberFormat.compact();
    return _compact.format(value);
  }
}
