import 'package:bfit_tracker/models/exercise.dart';
import 'package:bfit_tracker/models/workout.dart';
import 'package:bfit_tracker/repositories/exercise_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WorkoutRepository {
  final _workoutCollection = FirebaseFirestore.instance.collection('Workouts');

  Future<List<Workout>> retrieve() async {
    QuerySnapshot snapshot = await _workoutCollection.snapshots().first;
    List<QueryDocumentSnapshot> docs = snapshot.docs;
    List<Workout> workouts = [];
    List<Exercise> cachedExercises = [];
    for (QueryDocumentSnapshot queryDocumentSnapshot in docs) {
      Map<String, dynamic> workoutData = queryDocumentSnapshot.data();
      List<dynamic> rawExerciseDocRefs = workoutData['exercises'];
      List<dynamic> exerciseDocRefs = workoutData['exercises'];
      if (cachedExercises.isNotEmpty && exerciseDocRefs.isNotEmpty) {
        cachedExercises.forEach((cachedElement) {
          exerciseDocRefs
              .removeWhere((element) => element.id == cachedElement.docRef);
        });
      }

      List<Exercise> exercises =
          await ExerciseRepository().retrieve(exerciseDocRefs);
      cachedExercises.addAll(exercises);

      var exercisesForWorkout = [];
      if (rawExerciseDocRefs.isNotEmpty) {
        cachedExercises.forEach((cachedElement) {
          var docRef = rawExerciseDocRefs.firstWhere(
              (element) => cachedElement.docRef == element.id,
              orElse: () => null);
          if (docRef != null) {
            exercisesForWorkout.add(cachedElement);
          }
        });
      }

      workouts.add(Workout(queryDocumentSnapshot.id)
          .fromSnapshot(queryDocumentSnapshot, exercisesForWorkout));
    }

    return workouts;
  }
}
