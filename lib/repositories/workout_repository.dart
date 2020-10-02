import 'package:bfit_tracker/models/workout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WorkoutRepository {
  final _workoutCollection = FirebaseFirestore.instance.collection('Workouts');

  Future<List<Workout>> retrieve() async {
    var snapshots = _workoutCollection.snapshots();
    return snapshots
        .map((list) =>
            list.docs.map((doc) => Workout(doc.id).fromSnapshot(doc)).toList())
        .first;
  }
}
