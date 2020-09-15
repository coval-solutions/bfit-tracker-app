part of 'workout_bloc.dart';

abstract class WorkoutsEvent extends Equatable {
  const WorkoutsEvent();

  @override
  List<Object> get props => [];
}

class LoadWorkouts extends WorkoutsEvent {}

class SetWorkoutSelected extends WorkoutsEvent {
  final Workout _workout;

  SetWorkoutSelected(_workout) : _workout = _workout;

  @override
  List<Object> get props => [this._workout];

  @override
  String toString() => "SetWorkoutSelected { workout: ${this._workout} }";
}
