part of 'workout_bloc.dart';

abstract class WorkoutsEvent extends Equatable {
  const WorkoutsEvent();

  @override
  List<Object> get props => [];
}

class LoadCoursesData extends WorkoutsEvent {}
