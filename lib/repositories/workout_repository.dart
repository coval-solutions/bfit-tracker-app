import 'package:bfit_tracker/models/workout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WorkoutRepository {
  final _workoutCollection = Firestore.instance.collection('Workouts');

  Future<List<Workout>> retrieve() async {
    List<Workout> workouts = List<Workout>();
    final QuerySnapshot result = await _workoutCollection.getDocuments();
    result.documents.forEach((document) {
      workouts.add(Workout().fromSnapshot(document));
    });

    return workouts;
  }
}
