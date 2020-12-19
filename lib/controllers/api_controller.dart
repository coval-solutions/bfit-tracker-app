import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class ApiController {
  static String apiUrl =
      '${DotEnv().env['GOOGLE_FUNCTIONS_URL'] ?? 'http://localhost:5001/bfit-tracker-app/europe-west2/api'}';
}
