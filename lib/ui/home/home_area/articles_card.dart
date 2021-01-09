import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/models/article.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:bfit_tracker/ui/home/home_area/articles/articles_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ArticlesCard extends StatelessWidget {
  final List<Article> articles;

  ArticlesCard(this.articles);

  @override
  Widget build(BuildContext context) {
    Article article = articles.first;
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: SvgPicture.network(
                    article.imageUrl,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Positioned(
                  top: 2,
                  right: 12,
                  child: RaisedButton(
                    padding: const EdgeInsets.all(0),
                    disabledColor: mainTheme.accentColor,
                    onPressed: null,
                    child: AutoSizeText(
                      '${article.minsToRead} min read',
                      maxLines: 1,
                      minFontSize: 12,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ArticlesSelectionScreen(articles))),
              child: Container(
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
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topCenter,
                        child: AutoSizeText(
                          article.title,
                          maxLines: 2,
                          minFontSize: 16,
                          maxFontSize: 32,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 3,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                        child: AutoSizeText(
                          article.subtitle,
                          maxLines: 2,
                          minFontSize: 12,
                          maxFontSize: 28,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 16,
                        ),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: AutoSizeText(
                            article.author,
                            maxLines: 1,
                            maxFontSize: 12,
                            style: TextStyle(
                              color: Colors.white,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
