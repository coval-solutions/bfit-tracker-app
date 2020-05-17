import 'package:bfit_tracker/models/course.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CourseRepository {
  final _courseCollection = Firestore.instance.collection('Courses');

  Future<List<Course>> retrieve() async {
    List<Course> courses = List<Course>();
    final QuerySnapshot result = await _courseCollection.getDocuments();
    result.documents.forEach((document) {
      courses.add(Course().fromSnapshot(document));
    });

    return courses;
  }
}
