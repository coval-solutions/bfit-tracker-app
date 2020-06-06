import 'package:url_launcher/url_launcher.dart';

class GymController {
  static const String BASE_PLACE_ID_GOOGLE_MAPS_URL =
      'https://www.google.com/maps/dir/?api=1&destination=';

  static launchGoogleMaps(double lat, double lng) async {
    String url =
        BASE_PLACE_ID_GOOGLE_MAPS_URL + lat.toString() + "," + lng.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
