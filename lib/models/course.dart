import 'package:cloud_firestore/cloud_firestore.dart';

class Course {
  final String name;
  final int minutes;
  final String animationFilename;

  Course({this.name, this.minutes, this.animationFilename});

  Course fromSnapshot(DocumentSnapshot snapshot) {
    return Course(
      name: snapshot.data['name'] ?? '',
      minutes: snapshot.data['mins'] ?? 60,
      animationFilename: snapshot.data['filename'] ?? null,
    );
  }

  String getHumanReadableName() {
    return this.name.replaceAll(' ', '\n');
  }
}
