import 'package:bfit_tracker/models/exercise.dart';
import 'package:bfit_tracker/repositories/workout_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Workout {
  final String title;
  final String description;
  final String imageLocation;
  final bool isFast;
  final String type;
  final List<Exercise> exercises;

  Workout(
      {this.title,
      this.description,
      this.imageLocation,
      this.isFast,
      this.type,
      this.exercises});

  Workout fromSnapshot(DocumentSnapshot workoutSnapshot,
      List<DocumentSnapshot> exerciseSnapshots) {
    List<Exercise> exercises = [];
    for (DocumentSnapshot exerciseSnapshot in exerciseSnapshots) {
      exercises.add(Exercise().fromSnapshot(exerciseSnapshot));
    }

    var workout = Workout(
        title: workoutSnapshot.data['title'] ?? '',
        description: workoutSnapshot.data['description'] ?? '',
        imageLocation: workoutSnapshot.data['image_location'] ?? '',
        isFast: workoutSnapshot.data['is_fast'] ?? false,
        type: workoutSnapshot.data['type'] ?? 'Mixed',
        exercises: exercises);

    return workout;
  }

  String getHumanReadableDescription() {
    return this.description.replaceAll(' ', '\n');
  }

  String getWorkoutTiming() {
    int seconds = this
        .exercises
        .fold(0, (previousValue, element) => previousValue + element.seconds);

    var duration = Duration(seconds: seconds);

    return '${duration.inMinutes.remainder(60)}:${duration.inSeconds.remainder(60)}';
  }

  List<dynamic> getEquipment() {
    var equipmentList = [];
    for (Exercise exercise in this.exercises) {
      for (String equipment in exercise.equipment) {
        if (equipment.isNotEmpty) {
          equipmentList.add(equipment);
        }
      }
    }

    return equipmentList;
  }
}
