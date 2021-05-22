import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ArticleCardImage extends StatelessWidget {
  final String imageUrl;

  const ArticleCardImage({Key key, @required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.network(
      this.imageUrl,
      placeholderBuilder: (BuildContext context) => Container(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: const CircularProgressIndicator(),
        ),
      ),
      fit: BoxFit.scaleDown,
    );
  }
}
