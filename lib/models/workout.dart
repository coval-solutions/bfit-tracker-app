import 'package:cloud_firestore/cloud_firestore.dart';

class Workout {
  final String title;
  final String description;
  final String imageLocation;
  final bool isFast;
  final List<dynamic> types;
  final List<dynamic> workouts;

  Workout(
      {this.title,
      this.description,
      this.imageLocation,
      this.isFast,
      this.types,
      this.workouts});

  Workout fromSnapshot(DocumentSnapshot snapshot) {
    return Workout(
      title: snapshot.data['title'] ?? '',
      description: snapshot.data['description'] ?? '',
      imageLocation: snapshot.data['image_location'] ?? '',
      isFast: snapshot.data['is_fast'] ?? false,
      types: snapshot.data['types'] ?? ['Mixed'],
      workouts: snapshot.data['workouts'] ?? [],
    );
  }

  String getHumanReadableDescription() {
    return this.description.replaceAll(' ', '\n');
  }

  String getTypesString() {
    return this.types.join(', ').toUpperCase();
  }
}
