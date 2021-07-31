import 'package:bfit_tracker/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BackArrow extends StatelessWidget {
  final Color color;
  final BoxFit fit;

  BackArrow({
    this.color = CustomColor.SELECTIVE_YELLOW,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: SvgPicture.asset(
        'assets/images/left-pointing-arrow.svg',
        color: this.color,
        fit: this.fit,
        semanticsLabel: 'Left pointing arrow (back arrow)',
      ),
    );
  }
}
