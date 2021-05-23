import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:flutter/material.dart';

class ArticleCardMinsToRead extends StatelessWidget {
  final int minsToRead;

  const ArticleCardMinsToRead({Key key, @required this.minsToRead})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: null,
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(2),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          return states.contains(MaterialState.disabled)
              ? mainTheme.accentColor
              : mainTheme.primaryColor;
        }),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
      child: AutoSizeText(
        '${this.minsToRead} min read',
        maxLines: 2,
        minFontSize: 8,
        maxFontSize: 16,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
