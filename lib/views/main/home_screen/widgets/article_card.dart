import 'package:bfit_tracker/models/article.dart';
import 'package:bfit_tracker/views/main/home_screen/widgets/article_card_bottom.dart';
import 'package:bfit_tracker/views/main/home_screen/widgets/article_card_image.dart';
import 'package:bfit_tracker/views/main/home_screen/widgets/article_card_mins_to_read.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArticleCard extends StatelessWidget {
  final Article article;

  const ArticleCard({Key key, @required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        color: Colors.white,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 8,
                    ),
                    child: ArticleCardImage(
                      imageUrl: article.imageUrl,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 8,
                    ),
                    child: ArticleCardMinsToRead(
                      minsToRead: article.minsToRead,
                    ),
                  ),
                ),
              ],
            ),
            ArticleCardBottom(
              title: article.title,
              subtitle: article.subtitle,
              author: article.author,
            ),
          ],
        ),
      ),
    );
  }
}
