import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AnimatedCount extends StatefulWidget {
  final AnimationController animationController;
  final int count;
  final TextStyle textStyle;
  final String units;

  const AnimatedCount(
      {@required this.animationController,
      this.count = 1,
      @required this.textStyle,
      this.units = '',
      Key key})
      : super(key: key);

  @override
  _AnimatedCountState createState() =>
      _AnimatedCountState(animationController, count, textStyle, units);
}

class _AnimatedCountState extends State<AnimatedCount> {
  List<_AnimatedCount> animatedCounts = <_AnimatedCount>[];

  _AnimatedCountState(AnimationController animation, int count,
      TextStyle textStyle, String units);

  @override
  void initState() {
    super.initState();
    widget.count.toString().split('').forEach((ch) {
      StepTween stepTween = StepTween(begin: 0, end: int.parse(ch));
      animatedCounts.add(_AnimatedCount(
        animation: stepTween.animate(widget.animationController),
        textStyle: widget.textStyle,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: this.animatedCounts);
  }
}

class _AnimatedCount extends AnimatedWidget {
  final Animation<int> animation;
  final TextStyle textStyle;
  final String units;

  const _AnimatedCount(
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
            // children: <TextSpan>[
            //   TextSpan(
            //     text: this.units,
            //     style: TextStyle(
            //       fontWeight: FontWeight.normal,
            //       color: CustomColor.DIM_GRAY,
            //       fontSize: 16,
            //       letterSpacing: 1,
            //     ),
            //   ),
            // ],
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
