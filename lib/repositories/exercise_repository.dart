import 'package:bfit_tracker/models/exercise.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ExerciseRepository {
  Future<List<Exercise>> retrieve(List<dynamic> documentReferences) async {
    List<Exercise> exercises = [];
    for (DocumentReference documentReference in documentReferences) {
      DocumentSnapshot documentSnapshot =
          await documentReference.snapshots().first;
      exercises
          .add(Exercise(documentReference.id).fromSnapshot(documentSnapshot));
    }

    return exercises;
  }
}
