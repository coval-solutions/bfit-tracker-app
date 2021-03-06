import 'package:bfit_tracker/models/exercise.dart';
import 'package:bfit_tracker/utils/coval_math.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Workout {
  final String docRef;
  final String title;
  final String description;
  final String imageLocation;
  final bool isFast;
  final List<dynamic> exercises;

  String type;

  Workout(
    this.docRef, {
    this.title,
    this.description,
    this.imageLocation,
    this.isFast,
    this.exercises,
  });

  Workout fromSnapshot(DocumentSnapshot snapshot, List<dynamic> exercises) {
    Workout workout = Workout(
      docRef,
      title: snapshot.data()['title'] ?? '',
      description: snapshot.data()['description'] ?? '',
      imageLocation: snapshot.data()['image_location'] ?? '',
      isFast: snapshot.data()['is_fast'] ?? false,
      exercises: exercises,
    );

    workout.type = workout._calculateType();

    return workout;
  }

  String _calculateType() {
    Set types = {};
    for (Exercise exercise in this.exercises) {
      for (String type in exercise.type) {
        types.add(type);
      }
    }

    if (types.isEmpty) {
      return 'MIXED';
    }

    return types.length > 1 ? 'MIXED' : types.first.toString().toUpperCase();
  }

  String getHumanReadableDescription() {
    return this.description.replaceAll(' ', '\n');
  }

  String getWorkoutTiming() {
    int seconds = 0;
    if (exercises != null && exercises.isNotEmpty) {
      seconds = this
          .exercises
          .fold(0, (previousValue, element) => previousValue + element.seconds);
    }

    return CovalMath.getHumanreadableTime(seconds);
  }

  List<dynamic> getEquipment() {
    var equipmentList = [];
    if (exercises != null) {
      for (Exercise exercise in this.exercises) {
        for (String equipment in exercise.equipment) {
          equipment = equipment.trim();
          if (equipment.isNotEmpty && !equipmentList.contains(equipment)) {
            equipmentList.add(equipment);
          }
        }
      }
    }

    return equipmentList;
  }
}
