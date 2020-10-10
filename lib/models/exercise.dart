import 'package:cloud_firestore/cloud_firestore.dart';

class Exercise {
  final String docRef;
  final String name;
  final int seconds;
  final List<dynamic> equipment;
  final String imageLocation;

  Exercise(this.docRef,
      {this.name, this.seconds, this.equipment, this.imageLocation});

  Exercise fromSnapshot(DocumentSnapshot snapshot) {
    return Exercise(
      docRef,
      name: snapshot.data()['name'] ?? '',
      seconds: snapshot.data()['seconds'] ?? '',
      equipment: snapshot.data()['equipment'] ?? [],
      imageLocation: snapshot.data()['image_location'] ?? '',
    );
  }
}
