import 'package:bfit_tracker/models/goal.dart';
import 'package:bfit_tracker/models/user.dart';
import 'package:bfit_tracker/repos/firestore_repository.dart';
import 'package:bfit_tracker/repos/user_repository.dart';

class GoalsRepository {
  static const String COLLECTION_NAME = 'goals';

  GoalsRepository();

  Future<Goal> getGoals() async {
    User user = UserRepository.getCurrentUser();
    if (user != null) {
      return await this._fetch(user);
    }

    return null;
  }

  Future<Goal> _fetch(User user) async {
    final result = await FirestoreRepository.read("${GoalsRepository.COLLECTION_NAME}/${user.id}");
    return Goal.fromJson(result.data);
  }
}