import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReviewsIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/images/reviews_icon.svg',
        ),
        SizedBox(width: 6),
        AutoSizeText(
          'Reviews',
          minFontSize: 10,
          maxFontSize: 12,
          style: TextStyle(
            color: CustomColor.DIM_GRAY,
            fontWeight: FontWeight.normal,
          ),
        )
      ],
    );
  }
}
