import 'package:bfit_tracker/models/course.dart';

class CourseRepository {
  List<Course> courses;

  CourseRepository({List<Course> courses}) {
    this.courses = courses ?? generateCourses();
  }

  List<Course> generateCourses() {
    List<Course> courses = [
      Course(name: 'Toned', minutes: 120),
      Course(name: 'Tummy', minutes: 60),
      Course(name: 'Crazy', minutes: 30),
      Course(name: 'Triple', minutes: 120),
    ];
    
    return courses;
  }
}