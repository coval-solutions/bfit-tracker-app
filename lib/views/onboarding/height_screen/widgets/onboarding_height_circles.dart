import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HeightCirclesBackground extends StatelessWidget {
  const HeightCirclesBackground({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/images/onboarding/circles_height.svg',
      fit: BoxFit.contain,
      semanticsLabel: 'Background circles',
    );
  }
}
