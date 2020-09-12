part of 'workout_bloc.dart';

abstract class WorkoutsState extends Equatable {
  const WorkoutsState();

  @override
  List<Object> get props => [];
}

class WorkoutsNotLoaded extends WorkoutsState {}

class WorkoutsLoaded extends WorkoutsState {
  final List<Workout> _workouts;

  const WorkoutsLoaded(workouts)
      : assert(workouts != null),
        _workouts = workouts;

  @override
  List<Object> get props => [this._workouts];

  @override
  String toString() => "WorkoutsLoaded { workouts: ${this._workouts} }";
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

class WorkoutsLoading extends WorkoutsState {}
