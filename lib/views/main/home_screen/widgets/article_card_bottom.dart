import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:flutter/material.dart';

class ArticleCardBottom extends StatelessWidget {
  final String title;
  final String subtitle;
  final String author;

  const ArticleCardBottom(
      {Key key,
      @required this.title,
      @required this.subtitle,
      @required this.author})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minWidth: double.infinity,
      ),
      decoration: BoxDecoration(
        color: mainTheme.primaryColor,
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            AutoSizeText(
              this.title,
              maxLines: 2,
              minFontSize: 16,
              maxFontSize: 32,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            AutoSizeText(
              this.subtitle,
              maxLines: 2,
              minFontSize: 12,
              maxFontSize: 28,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Align(
              alignment: Alignment.bottomRight,
              child: AutoSizeText(
                this.author,
                maxLines: 1,
                maxFontSize: 12,
                style: TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
