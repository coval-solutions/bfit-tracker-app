import 'dart:async';

import 'package:bfit_tracker/models/course.dart';
import 'package:bfit_tracker/repositories/course_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'courses_event.dart';
part 'courses_state.dart';

class CoursesBloc extends Bloc<CoursesEvent, CoursesState> {
  final CourseRepository _courseRepository;

  CoursesBloc({@required CourseRepository courseRepository})
      : assert(courseRepository != null),
        _courseRepository = courseRepository;

  @override
  CoursesState get initialState => CoursesNotLoaded();

  @override
  Stream<CoursesState> mapEventToState(
    CoursesEvent event,
  ) async* {
    if (event is LoadCoursesData) {
      yield* _mapLoadingToState(event);
    }
  }

  Stream<CoursesState> _mapLoadingToState(LoadCoursesData event) async* {
    try {
      yield CoursesDataLoaded(_courseRepository.retrieve());
    } catch (_) {
      yield CoursesNotLoaded();
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
