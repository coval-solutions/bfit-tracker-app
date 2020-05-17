import 'package:cloud_firestore/cloud_firestore.dart';

class Course {
  final String name;
  final int minutes;

  Course({this.name, this.minutes});

  Course fromSnapshot(DocumentSnapshot snapshot) {
    return Course(
      name: snapshot.data['name'] ?? '',
      minutes: snapshot.data['mins'] ?? 60,
    );
  }
}
