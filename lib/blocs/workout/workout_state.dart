part of 'workout_bloc.dart';

abstract class WorkoutsState extends Equatable {
  const WorkoutsState();

  @override
  List<Object> get props => [];
}

class CoursesNotLoaded extends WorkoutsState {}

class CoursesDataLoaded extends WorkoutsState {
  final Future<List<Workout>> _courses;

  const CoursesDataLoaded(courses)
      : assert(courses != null),
        _courses = courses;

  @override
  List<Object> get props => [this._courses];

  @override
  String toString() => "CoursesDataLoaded { courses: ${this._courses} }";
}

class WorkoutSelected extends WorkoutsState {
  final Workout _workout;

  const WorkoutSelected(_workout)
      : assert(_workout != null),
        _workout = _workout;

  @override
  List<Object> get props => [this._workout];

  @override
  String toString() => "WorkoutSelected { workout: ${this._workout} }";
}

class CoursesDataLoading extends WorkoutsState {}
