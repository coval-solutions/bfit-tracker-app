import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/models/article.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:bfit_tracker/ui/coval_solutions/back_arrow.dart';
import 'package:bfit_tracker/ui/home/home_area/articles/article_image_card.dart';
import 'package:bfit_tracker/ui/home/home_area/articles/articles_star_rating.dart';
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 32,
                  left: 16,
                ),
                child: BackArrow(
                  color: CustomColor.DIM_GRAY,
                ),
              ),
              SizedBox(height: 18),
              Container(
                height: size.height,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 45,
                        left: 40,
                      ),
                      child: Container(
                        width: size.width,
                        color: CustomColor.GREY_CHATEAU.withOpacity(0.12),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 174,
                            top: 28,
                            right: 9,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AutoSizeText(
                                this.article.title,
                                minFontSize: 18,
                                style: TextStyle(
                                  color: CustomColor.NIGHT_RIDER,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 20),
                              AutoSizeText(
                                'By ${this.article.author}',
                                minFontSize: 12,
                                style: TextStyle(
                                  color: CustomColor.DIM_GRAY,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 24),
                              ArticleStarRating(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
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
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
