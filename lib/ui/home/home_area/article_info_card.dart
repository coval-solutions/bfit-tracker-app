import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/models/article.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ArticleInfoCard extends StatelessWidget {
  final Article article;

  // TODO: get this figure from somewhere else
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
        // Navigator.of(context).pushReplacement(MaterialPageRoute(
        //     builder: (BuildContext context) => WorkoutCountdown(number: 5)));
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
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: this.numOfStars,
                  itemBuilder: (context, index) {
                    if (index == this.numOfStars - 1) {
                      return Row(
                        children: [
                          SvgPicture.asset('assets/images/star.svg'),
                          SizedBox(width: 4),
                          AutoSizeText(
                            this.numOfStars.toStringAsFixed(1),
                            minFontSize: 8,
                            maxFontSize: 10,
                            style: TextStyle(
                              color: CustomColor.SELECTIVE_YELLOW,
                            ),
                          ),
                        ],
                      );
                    }
                    return SvgPicture.asset('assets/images/star.svg');
                  },
                ),
              ),
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
