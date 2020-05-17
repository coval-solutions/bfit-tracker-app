part of 'courses_bloc.dart';

abstract class CoursesState extends Equatable {
  const CoursesState();

  @override
  List<Object> get props => [];
}

class CoursesNotLoaded extends CoursesState {}

class CoursesDataLoaded extends CoursesState {
  final Future<List<Course>> _courses;

  const CoursesDataLoaded(courses)
      : assert(courses != null),
        _courses = courses;

  @override
  List<Object> get props => [this._courses];

  @override
  String toString() => "CoursesDataLoaded { courses: ${this._courses} }";
}

class CoursesDataLoading extends CoursesState {}
