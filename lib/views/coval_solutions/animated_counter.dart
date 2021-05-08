import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class AnimatedCounter extends StatefulWidget {
  final int count;
  final TextStyle textStyle;
  final String unitText;
  final TextStyle unitTextStyle;
  final double textMaxFontSize;
  final double minTextFontSize;
  final double unitMaxFontSize;
  final double unitMinFontSize;

  AnimatedCounter(
      {Key key,
      @required this.count,
      this.textStyle,
      this.minTextFontSize = 20.0,
      this.textMaxFontSize = 28.0,
      this.unitText,
      this.unitTextStyle,
      this.unitMinFontSize = 12.0,
      this.unitMaxFontSize = 16.0})
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
    text = <Widget>[];
    animationControllers = <AnimationController>[];
    animations = <Animation<int>>[];
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
          unitTextStyle: widget.unitTextStyle,
          maxTextFontSize: widget.textMaxFontSize,
          unitMaxFontSize: widget.unitMaxFontSize,
          minTextFontSize: widget.minTextFontSize,
          unitMinFontSize: widget.unitMinFontSize);
    }

    return _AnimatedCount(
        animation: animations.last,
        textStyle: widget.textStyle,
        maxTextFontSize: widget.textMaxFontSize,
        unitMaxFontSize: widget.unitMaxFontSize,
        minTextFontSize: widget.minTextFontSize,
        unitMinFontSize: widget.unitMinFontSize);
  }

  Animation<int> createAnimation(
      int number, AnimationController animationController) {
    return IntTween(begin: 0, end: number).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(
          0,
          0.6,
          curve: Curves.fastOutSlowIn,
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
  final double minTextFontSize;
  final double maxTextFontSize;
  final String unitText;
  final TextStyle unitTextStyle;
  final double unitMinFontSize;
  final double unitMaxFontSize;

  const _AnimatedCount(
      {@required this.animation,
      @required this.textStyle,
      @required this.maxTextFontSize,
      @required this.unitMaxFontSize,
      @required this.minTextFontSize,
      @required this.unitMinFontSize,
      this.unitText,
      this.unitTextStyle,
      Key key})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    if (unitText != null && unitText.isNotEmpty) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          AutoSizeText.rich(
            TextSpan(text: animation.value.toString(), style: this.textStyle),
            minFontSize: this.minTextFontSize,
            maxFontSize: this.maxTextFontSize,
          ),
          AutoSizeText.rich(
            TextSpan(
                text: this.unitText,
                style: this.unitTextStyle ?? this.textStyle),
            minFontSize: this.unitMinFontSize,
            maxFontSize: this.unitMaxFontSize,
          ),
        ],
      );
    }

    return AutoSizeText.rich(
      TextSpan(
        text: animation.value.toString(),
        style: textStyle,
      ),
      minFontSize: this.minTextFontSize,
      maxFontSize: this.maxTextFontSize,
    );
  }
}
