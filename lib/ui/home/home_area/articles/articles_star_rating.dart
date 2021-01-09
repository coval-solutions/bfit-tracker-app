import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../theme.dart';

class ArticleStarRating extends StatelessWidget {
  final int numOfStars;
  List<Widget> list = List<Widget>();

  ArticleStarRating({this.numOfStars = 5}) {
    for (var i = 1; i <= numOfStars; i++) {
      if (i == numOfStars) {
        list.add(SvgPicture.asset('assets/images/star.svg'));
        list.add(SizedBox(width: 4));
        list.add(AutoSizeText(
          this.numOfStars.toStringAsFixed(1),
          minFontSize: 8,
          maxFontSize: 10,
          style: TextStyle(
            color: CustomColor.SELECTIVE_YELLOW,
          ),
        ));
      } else {
        list.add(SvgPicture.asset('assets/images/star.svg'));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: this.list,
    );
  }
}
