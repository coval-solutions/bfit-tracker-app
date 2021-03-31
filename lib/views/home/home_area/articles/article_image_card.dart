import 'package:bfit_tracker/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ArticleImageCard extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;
  final double width;
  final EdgeInsets padding;

  ArticleImageCard(
    this.imageUrl, {
    this.fit = BoxFit.fitWidth,
    this.width,
    this.padding = const EdgeInsets.all(12.0),
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: mainTheme.primaryColor,
      child: Padding(
        padding: this.padding,
        child: SvgPicture.network(
          this.imageUrl,
          width: this.width,
          fit: this.fit,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }
}
