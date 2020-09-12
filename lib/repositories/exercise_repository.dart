import 'package:bfit_tracker/models/exercise.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ExerciseRepository {
  Future<List<Exercise>> retrieve(List<dynamic> documentReferences) async {
    List<Exercise> exercises = [];
    for (DocumentReference docRef in documentReferences) {
      DocumentSnapshot documentSnapshot = await docRef.get();
      exercises.add(Exercise().fromSnapshot(documentSnapshot));
    }

    return exercises;
  }
}
