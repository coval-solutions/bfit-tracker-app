import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:transformer_page_view/transformer_page_view.dart';

class OnboardingBackgroundCircles extends StatelessWidget {
  const OnboardingBackgroundCircles({
    Key key,
    @required this.transformInfo,
    @required this.backgroundAssetPath,
  }) : super(key: key);

  final TransformInfo transformInfo;
  final String backgroundAssetPath;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      this.backgroundAssetPath,
      fit: BoxFit.contain,
      semanticsLabel: 'Background circles',
    );
  }
}
