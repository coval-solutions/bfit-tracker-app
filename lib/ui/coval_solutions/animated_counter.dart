import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class AnimatedCounter extends StatefulWidget {
  final int count;
  final TextStyle textStyle;
  final String unitText;
  final TextStyle unitTextStyle;

  AnimatedCounter(
      {Key key,
      @required this.count,
      this.textStyle,
      this.unitText,
      this.unitTextStyle})
      : super(key: key);

  @override
  _AnimatedCounterState createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
    with TickerProviderStateMixin {
  List<Widget> text;
  List<AnimationController> animationControllers;
  List<Animation<int>> animations;

  @override
  void initState() {
    super.initState();
    text = List<Widget>();
    animationControllers = List<AnimationController>();
    animations = List<Animation<int>>();
    String countString = widget.count.toString();
    for (int i = 0; i < (countString.length - 1); i++) {
      int count = int.parse(countString[i]);
      animationControllers.add(this.createAnimationController(count));
      animations.add(createAnimation(count, animationControllers.last));
      text.add(this.createWidget());
    }

    int lastNum = int.parse(countString[countString.length - 1]);
    animationControllers.add(this.createAnimationController(lastNum));
    animations.add(createAnimation(lastNum, animationControllers.last));
    text.add(this.createWidget(unit: widget.unitText));
  }

  @override
  void dispose() {
    for (AnimationController animationController in animationControllers) {
      animationController.dispose();
    }

    super.dispose();
  }

  Widget createWidget({String unit = ''}) {
    if (unit != null && unit.isNotEmpty) {
      return _AnimatedCount(
          animation: animations.last,
          textStyle: widget.textStyle,
          unitText: widget.unitText,
          unitTextStyle: widget.unitTextStyle);
    }

    return _AnimatedCount(
        animation: animations.last, textStyle: widget.textStyle);
  }

  Animation<int> createAnimation(
      int number, AnimationController animationController) {
    return IntTween(begin: 0, end: number).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(
          0,
          0.2,
          curve: Curves.ease,
        ),
      ),
    );
  }

  AnimationController createAnimationController(int number) {
    return AnimationController(
      vsync: this,
      duration: Duration(seconds: number ~/ 2),
    );
  }

  onAfterBuild(BuildContext context) {
    for (AnimationController animationController in animationControllers) {
      animationController..forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => onAfterBuild(context));

    return Row(
      children: this.text,
    );
  }
}

class _AnimatedCount extends AnimatedWidget {
  final Animation<int> animation;
  final TextStyle textStyle;
  final String unitText;
  final TextStyle unitTextStyle;

  const _AnimatedCount(
      {@required this.animation,
      @required this.textStyle,
      this.unitText,
      this.unitTextStyle,
      Key key})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    if (unitText != null && unitText.isNotEmpty) {
      return AutoSizeText.rich(
        TextSpan(
          text: '',
          style: textStyle,
          children: <TextSpan>[
            TextSpan(
              text: animation.value.toString(),
            ),
            TextSpan(
                text: this.unitText,
                style: this.unitTextStyle ?? this.textStyle),
          ],
        ),
      );
    }

    return AutoSizeText.rich(
      TextSpan(
        text: '',
        style: textStyle,
        children: <TextSpan>[
          TextSpan(
            text: animation.value.toString(),
          ),
        ],
      ),
    );
  }
}
