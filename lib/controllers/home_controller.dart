import 'package:bfit_tracker/models/article.dart';
import 'package:bfit_tracker/models/gym.dart';
import 'package:bfit_tracker/repositories/article_repository.dart';
import 'package:bfit_tracker/repositories/gym_repository.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController extends GetxController {
  static const String BASE_PLACE_ID_GOOGLE_MAPS_URL =
      'https://www.google.com/maps/dir/?api=1&destination=';

  ArticleRepository _articleRepository = ArticleRepository();
  GymRepository _gymRepository = GymRepository();

  Rx<List<Article>> _articles = new Rx<List<Article>>(null);
  Rx<List<Gym>> _gymsNearMe = new Rx<List<Gym>>(null);

  List<Article> get articles => _articles.value;
  List<Gym> get gymsNearMe => _gymsNearMe.value;

  set articles(List<Article> value) => this._articles.value = value;
  set gymsNearMe(List<Gym> value) => this._gymsNearMe.value = value;

  @override
  Future<void> onInit() async {
    super.onInit();
    await this.getArticles();
    await this.getGymsNearMe();
  }

  Future<void> getArticles() async {
    Stream<List<Article>> articlesStream = _articleRepository.retrieveAll();
    if (articlesStream != null) {
      this.articles = await articlesStream.first;
    }

    return;
  }

  Future<void> getGymsNearMe() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    this.gymsNearMe = await _gymRepository.retrieve(position);
    return;
  }

  Future<void> launchGoogleMaps(double lat, double lng) async {
    String url =
        BASE_PLACE_ID_GOOGLE_MAPS_URL + lat.toString() + "," + lng.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }

    return;
  }
}
