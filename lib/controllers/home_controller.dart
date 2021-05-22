import 'package:bfit_tracker/models/article.dart';
import 'package:bfit_tracker/repositories/article_repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  ArticleRepository _articleRepository = ArticleRepository();
  Rx<List<Article>> _articles = new Rx<List<Article>>(null);

  List<Article> get articles => _articles.value;

  set articles(List<Article> value) => this._articles.value = value;

  @override
  Future<void> onInit() async {
    super.onInit();
    await this.getArticles();
  }

  Future<void> getArticles() async {
    Stream<List<Article>> articlesStream = _articleRepository.retrieveAll();
    if (articlesStream != null) {
      this.articles = await articlesStream.first;
    }

    return;
  }
}
