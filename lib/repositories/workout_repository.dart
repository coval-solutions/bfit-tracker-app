import 'package:bfit_tracker/models/workout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WorkoutRepository {
  final _workoutCollection = Firestore.instance.collection('Workouts');

  Future<List<Workout>> retrieve() async {
    var snapshots = _workoutCollection.snapshots();
    return snapshots
        .map((list) =>
            list.documents.map((doc) => Workout().fromSnapshot(doc)).toList())
        .first;
  }
}
