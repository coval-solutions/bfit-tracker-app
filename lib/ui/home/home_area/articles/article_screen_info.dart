import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/models/article.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:bfit_tracker/ui/home/home_area/articles/articles_star_rating.dart';
import 'package:bfit_tracker/ui/home/home_area/articles/google_doc.dart';
import 'package:bfit_tracker/ui/home/home_area/articles/like_icon.dart';
import 'package:bfit_tracker/ui/home/home_area/articles/reviews_icon.dart';
import 'package:bfit_tracker/ui/home/home_area/articles/share_icon.dart';
import 'package:flutter/material.dart';

class ArticleScreenMainBody extends StatelessWidget {
  final Article article;

  ArticleScreenMainBody(this.article);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.only(left: 132),
            child: AutoSizeText(
              this.article.title,
              minFontSize: 18,
              style: TextStyle(
                color: CustomColor.NIGHT_RIDER,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 132),
            child: AutoSizeText(
              'By ${this.article.author}',
              minFontSize: 12,
              style: TextStyle(
                color: CustomColor.DIM_GRAY,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.only(left: 132),
            child: ArticleStarRating(
              numOfReviews: 198,
            ),
          ),
          SizedBox(height: 36),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ReviewsIcon(),
                LikeIcon(),
                ShareIcon(),
              ],
            ),
          ),
          Divider(),
          Expanded(
            child: GoogleDoc(),
          ),
        ],
      ),
    );
  }
}
