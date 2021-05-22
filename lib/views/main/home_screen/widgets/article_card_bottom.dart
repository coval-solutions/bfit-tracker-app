import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:bfit_tracker/utils.dart';
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
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: mainTheme.primaryColor,
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: AutoSizeText(
                  this.title,
                  maxLines: 2,
                  minFontSize: Utils.isSmallScreen() ? 16 : 20,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Spacer(),
              AutoSizeText(
                this.subtitle,
                maxLines: 2,
                minFontSize: Utils.isSmallScreen() ? 12 : 16,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              Spacer(),
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
      ),
    );
  }
}
