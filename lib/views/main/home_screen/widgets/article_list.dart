import 'package:bfit_tracker/controllers/home_controller.dart';
import 'package:bfit_tracker/views/main/home_screen/widgets/article_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArticleList extends GetView<HomeController> {
  const ArticleList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: controller.articles.length,
      options: CarouselOptions(aspectRatio: 4 / 3),
      itemBuilder: (BuildContext context, int index, int realIndex) =>
          ArticleCard(article: controller.articles[index]),
    );
  }
}
