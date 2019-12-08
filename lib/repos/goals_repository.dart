import 'package:bfit_tracker/models/goal.dart';
import 'package:bfit_tracker/models/user.dart';
import 'package:bfit_tracker/repos/firestore_repository.dart';
import 'package:bfit_tracker/repos/user_repository.dart';

class GoalsRepository {
  static const String COLLECTION_NAME = 'goals';
  static Goal _goals;

  GoalsRepository();

  Future<Goal> getGoals() async {
    User user = UserRepository.getCurrentUser();
    if (user != null) {
      if (GoalsRepository._goals != null) {
        return GoalsRepository._goals;
      }

      return await this._fetch(user);
    }

    return null;
  }

  Future<Goal> _fetch(User user) async {
    final result = await FirestoreRepository.read("${GoalsRepository.COLLECTION_NAME}/${user.id}");
    final goals = Goal.fromJson(result.data);

    GoalsRepository._goals = goals;
    return goals;
  }
}