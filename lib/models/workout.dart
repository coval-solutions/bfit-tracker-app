import 'package:cloud_firestore/cloud_firestore.dart';

class Workout {
  final String title;
  final String description;
  final String imageLocation;
  final bool isFast;
  final List<String> types;

  Workout(
      {this.title,
      this.description,
      this.imageLocation,
      this.isFast,
      this.types});

  Workout fromSnapshot(DocumentSnapshot snapshot) {
    return Workout(
      title: snapshot.data['title'] ?? '',
      description: snapshot.data['description'] ?? '',
      imageLocation: snapshot.data['image_location'] ?? '',
      isFast: snapshot.data['is_fast'] ?? false,
      types: snapshot.data['types'] ?? ['Mixed'],
    );
  }

  String getHumanReadableName() {
    return this.title.replaceAll(' ', '\n');
  }

  String getTypesString() {
    return this.types.join(', ');
  }
}
