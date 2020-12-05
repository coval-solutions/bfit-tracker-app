import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/models/article.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:flutter/material.dart';

class ArticlesScreen extends StatelessWidget {
  final List<Article> articles;

  ArticlesScreen(this.articles);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainTheme.primaryColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 24,
                top: 36,
              ),
              child: AutoSizeText(
                'Latest Articles',
                minFontSize: 24,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 18,
            ),
            Row(
              children: [
                SizedBox(width: 16),
                Expanded(
                  child: RaisedButton(
                    elevation: 2,
                    onPressed: () {},
                    child: const Text(
                      'New',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    color: Colors.white,
                    textColor: mainTheme.primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: RaisedButton(
                    elevation: 2,
                    onPressed: () {},
                    child: const Text(
                      'Quick Read',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    color: Colors.white,
                    textColor: mainTheme.primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: RaisedButton(
                    elevation: 2,
                    onPressed: () {},
                    child: const Text(
                      'Suggested',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    color: Colors.white,
                    textColor: mainTheme.primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                  ),
                ),
                SizedBox(width: 16),
              ],
            ),
            SizedBox(
              height: 18,
            ),
            Expanded(
              child: Card(
                margin: EdgeInsets.zero,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: articles.length,
                  itemBuilder: (context, index) => Text(articles[index].title),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
