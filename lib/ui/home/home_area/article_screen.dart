import 'package:bfit_tracker/models/article.dart';
import 'package:bfit_tracker/ui/home/home_area/google_doc.dart';
import 'package:flutter/material.dart';

class ArticleScreen extends StatefulWidget {
  final Article article;

  ArticleScreen(this.article);

  @override
  _ArticleScreenState createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  @override
  Widget build(BuildContext context) {
    print(this.widget.article.textUrl);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GoogleDoc(),
      ),
    );
  }
}
