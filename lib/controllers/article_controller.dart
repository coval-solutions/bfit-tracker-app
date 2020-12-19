import 'dart:convert';
import 'dart:io';

import 'package:bfit_tracker/controllers/api_controller.dart';
import 'package:bfit_tracker/repositories/user_repository.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:http/http.dart' as http;

class ArticleController extends ApiController {
  static Future<dynamic> fetchArticleViewedCount() async {
    String token = await UserRepository.getIdToken();

    final resp = await http.get('${ApiController.apiUrl}/article-viewed-counts',
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
    if (resp.statusCode == 200) {
      try {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        return json.decode(resp.body);
      } catch (e) {
        FirebaseCrashlytics.instance.recordError(e, StackTrace.current,
            reason: 'Failed to decode JSON response');
        return null;
      }
    } else {
      // If the server did not return a 200 OK response,
      // then return the default value of 0, and report to Crashlytics.
      FirebaseCrashlytics.instance.recordError(
        Exception('Failed to load Article viewed count'),
        StackTrace.current,
        reason: resp.statusCode,
      );

      return null;
    }
  }
}
