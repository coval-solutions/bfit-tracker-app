import 'dart:async';

import 'package:bfit_tracker/models/workout.dart';
import 'package:bfit_tracker/repositories/workout_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'workout_event.dart';
part 'workout_state.dart';

class WorkoutBloc extends Bloc<WorkoutsEvent, WorkoutsState> {
  final WorkoutRepository _workoutRepository;

  WorkoutBloc({@required WorkoutRepository courseRepository})
      : assert(courseRepository != null),
        _workoutRepository = courseRepository;

  @override
  WorkoutsState get initialState => CoursesNotLoaded();

  @override
  Stream<WorkoutsState> mapEventToState(
    WorkoutsEvent event,
  ) async* {
    if (event is LoadCoursesData) {
      yield* _mapLoadingToState(event);
    }
  }

  Stream<WorkoutsState> _mapLoadingToState(LoadCoursesData event) async* {
    try {
      yield CoursesDataLoaded(_workoutRepository.retrieve());
    } catch (_) {
      yield CoursesNotLoaded();
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
