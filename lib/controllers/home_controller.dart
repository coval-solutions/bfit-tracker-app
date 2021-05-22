import 'package:bfit_tracker/models/article.dart';
import 'package:bfit_tracker/repositories/article_repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  ArticleRepository _articleRepository = ArticleRepository();
  Rx<Article> _latestArticle = new Rx<Article>(null);

  Article get latestArticle => _latestArticle.value;

  @override
  Future<void> onInit() async {
    super.onInit();
    await this.getLatestArticle();
  }

  Future<void> getLatestArticle() async {
    Stream<List<Article>> articlesStream = _articleRepository.retrieveLatest();
    if (articlesStream != null) {
      List<Article> articles = await articlesStream.first;
      _latestArticle.value = articles.first;
    }

    return;
  }
}
