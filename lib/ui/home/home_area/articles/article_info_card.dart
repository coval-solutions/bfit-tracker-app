import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/models/article.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:bfit_tracker/ui/home/home_area/articles/article_screen.dart';
import 'package:bfit_tracker/ui/home/home_area/articles/articles_star_rating.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

class ArticleInfoCard extends StatelessWidget {
  final Article article;

  // TODO: get thi star rating figure from somewhere else
  final int numOfStars = 5;
  final int viewCount;

  const ArticleInfoCard({
    Key key,
    @required this.article,
    this.viewCount = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        String eventName = 'article_${this.article.docRef}_click';
        FirebaseAnalytics().logEvent(name: eventName);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => ArticleScreen(this.article)));
      },
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                this.article.title,
                minFontSize: 18,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              AutoSizeText(
                'By ${this.article.author}',
                minFontSize: 12,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: CustomColor.GREY_CHATEAU,
                ),
              ),
              SizedBox(height: 10),
              ArticleStarRating(
                numOfStars: 5,
              ),
              Spacer(),
              Row(
                children: [
                  AutoSizeText.rich(
                    TextSpan(
                      text: this.viewCount.toString(),
                      style: TextStyle(
                        color: mainTheme.accentColor,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: ' Views',
                          style: TextStyle(
                            color: CustomColor.GREY_CHATEAU,
                          ),
                        ),
                      ],
                    ),
                    minFontSize: 12,
                  ),
                ],
              )
            ],
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
