import 'package:bfit_tracker/models/workout.dart';
import 'package:bfit_tracker/repositories/exercise_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WorkoutRepository {
  final _workoutCollection = Firestore.instance.collection('Workouts');

  Future<List<Workout>> retrieve() async {
    List<Workout> workouts = [];
    final QuerySnapshot result = await _workoutCollection.getDocuments();
    for (DocumentSnapshot documentSnapshot in result.documents) {
      List<DocumentSnapshot> exercises = await ExerciseRepository.retrieveList(
          documentSnapshot.data['exercises'] ?? []);
      workouts.add(Workout().fromSnapshot(documentSnapshot, exercises));
    }

    return workouts;
  }
}
