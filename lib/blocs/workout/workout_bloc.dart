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

  WorkoutBloc({@required WorkoutRepository workoutRepository})
      : assert(workoutRepository != null),
        _workoutRepository = workoutRepository;

  @override
  WorkoutsState get initialState => WorkoutsNotLoaded();

  @override
  Stream<WorkoutsState> mapEventToState(
    WorkoutsEvent event,
  ) async* {
    if (event is LoadWorkouts) {
      yield* _mapLoadingToState(event);
    } else if (event is SetWorkoutSelected) {
      yield* _mapSelectedToState(event);
    }
  }

  Stream<WorkoutsState> _mapSelectedToState(SetWorkoutSelected event) async* {
    try {
      yield WorkoutSelected(event._workout);
    } catch (_) {
      print(_);
      yield WorkoutsNotLoaded();
    }
  }

  Stream<WorkoutsState> _mapLoadingToState(LoadWorkouts event) async* {
    try {
      yield WorkoutsLoading();
      // TODO: add some sort of caching
      var workouts = await _workoutRepository.retrieve();
      yield WorkoutsLoaded(workouts);
    } catch (_) {
      print(_);
      yield WorkoutsNotLoaded();
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
