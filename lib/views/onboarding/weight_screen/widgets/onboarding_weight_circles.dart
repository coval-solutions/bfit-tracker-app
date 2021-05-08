import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WeightCirclesBackground extends StatelessWidget {
  const WeightCirclesBackground({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/images/onboarding/circles_weight.svg',
      fit: BoxFit.contain,
      semanticsLabel: 'Background circles',
    );
  }
}
