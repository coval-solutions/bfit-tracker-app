import 'package:bfit_tracker/models/exercise.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ExerciseRepository {
  static Future<Exercise> retrieve(DocumentReference documentReference) async {
    final DocumentSnapshot documentSnapshot = await documentReference.get();
    return Exercise().fromSnapshot(documentSnapshot);
  }

  static Future<List<DocumentSnapshot>> retrieveList(
      List<dynamic> documentReferences) async {
    List<DocumentSnapshot> snapshots = [];

    for (DocumentReference docRef in documentReferences) {
      DocumentSnapshot documentSnapshot = await docRef.get();
      snapshots.add(documentSnapshot);
    }

    return snapshots;
  }
}
