import 'package:cloud_firestore/cloud_firestore.dart';

class Exercise {
  final String name;
  final int seconds;
  final bool equipmentNeeded;
  final String imageLocation;

  Exercise({this.name, this.seconds, this.equipmentNeeded, this.imageLocation});

  Exercise fromSnapshot(DocumentSnapshot snapshot) {
    return Exercise(
      name: snapshot.data['name'] ?? '',
      seconds: snapshot.data['seconds'] ?? '',
      equipmentNeeded: snapshot.data['equipment'] ?? false,
      imageLocation: snapshot.data['image_location'] ?? '',
    );
  }
}
