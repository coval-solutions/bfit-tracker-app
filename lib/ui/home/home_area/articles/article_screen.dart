import 'package:bfit_tracker/models/article.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:bfit_tracker/ui/coval_solutions/back_arrow.dart';
import 'package:bfit_tracker/ui/home/home_area/articles/article_image_card.dart';
import 'package:bfit_tracker/ui/home/home_area/articles/article_screen_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ArticleScreen extends StatelessWidget {
  final Article article;

  ArticleScreen(this.article);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 124, left: 52),
              child: Container(
                color: CustomColor.DIM_GRAY.withOpacity(0.12),
                child: ArticleScreenMainBody(this.article),
              ),
            ),
            Positioned(
              top: 64,
              left: -36,
              child: ArticleImageCard(
                this.article.imageUrl,
                width: size.width * 0.5,
                padding: const EdgeInsets.symmetric(
                  vertical: 60,
                  horizontal: 8,
                ),
              ),
            ),
            Positioned(
              top: 22,
              left: 12,
              child: BackArrow(
                color: CustomColor.DIM_GRAY,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
