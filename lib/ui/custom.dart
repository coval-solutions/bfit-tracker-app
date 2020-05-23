import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/theme.dart';
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
  final String units;

  const AnimatedCount(
      {@required this.animation,
      @required this.textStyle,
      this.units = '',
      Key key})
      : super(key: key, listenable: animation);

  @override
  build(BuildContext context) {
    if (this.units.isNotEmpty) {
      return AutoSizeText.rich(
          TextSpan(
            text: animation.value.toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: mainTheme.accentColor,
              fontSize: 28,
              letterSpacing: 8,
            ),
            children: <TextSpan>[
              TextSpan(
                text: this.units,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: CustomColor.DIM_GRAY,
                  fontSize: 16,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          maxLines: 1);
    }

    return AutoSizeText(
      animation.value.toString(),
      style: textStyle,
      maxLines: 1,
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
