import 'package:bfit_tracker/models/course_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Course {
  final String name;
  final int minutes;
  final String animationFilename;
  final CourseDetail courseDetail;

  Course({this.name, this.minutes, this.animationFilename, this.courseDetail});

  Course fromSnapshot(DocumentSnapshot snapshot) {
    return Course(
      name: snapshot.data['name'] ?? '',
      minutes: snapshot.data['mins'] ?? 60,
      animationFilename: snapshot.data['filename'] ?? '',
      courseDetail: snapshot.data['details'] != null
          ? CourseDetail.fromJson(snapshot.data['details'])
          : null,
    );
  }

  String getHumanReadableName() {
    return this.name.replaceAll(' ', '\n');
  }
}
