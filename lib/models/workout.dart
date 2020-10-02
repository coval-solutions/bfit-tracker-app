import 'package:bfit_tracker/models/exercise.dart';
import 'package:bfit_tracker/models/firebase_collection.dart';
import 'package:bfit_tracker/utils/coval_math.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Workout extends FirebaseCollection {
  final String title;
  final String description;
  final String imageLocation;
  final bool isFast;
  final String type;
  final List<dynamic> exerciseDocRefs;
  List<Exercise> exercises;

  Workout(
    String docRef, {
    this.title,
    this.description,
    this.imageLocation,
    this.isFast,
    this.type,
    this.exerciseDocRefs,
  }) : super(docRef);

  Workout fromSnapshot(DocumentSnapshot snapshot) {
    return Workout(
      docRef,
      title: snapshot.data()['title'] ?? '',
      description: snapshot.data()['description'] ?? '',
      imageLocation: snapshot.data()['image_location'] ?? '',
      isFast: snapshot.data()['is_fast'] ?? false,
      type: snapshot.data()['type'] ?? 'Mixed',
      exerciseDocRefs: snapshot.data()['exercises'] ?? [],
    );
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

  void setExercises(List<Exercise> exercises) {
    this.exercises = exercises;
  }
}
