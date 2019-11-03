import 'package:bfit_tracker/controllers/firestore_controller.dart';
import 'package:bfit_tracker/models/goal.dart';
import 'package:bfit_tracker/models/user.dart';

class GoalController {
  static const String COLLECTION_NAME = 'goals';

  static Future<Goal> getGoals(User user) async {
    final result = await FirestoreDB.read("${GoalController.COLLECTION_NAME}/${user.id}");
    return Goal.fromJson(result.data);
  }
}