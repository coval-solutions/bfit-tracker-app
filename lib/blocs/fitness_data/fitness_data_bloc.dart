import 'dart:async';

import 'package:bfit_tracker/models/fitness_stat.dart';
import 'package:bfit_tracker/repositories/fitness_data_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health/health.dart';
import 'package:jiffy/jiffy.dart';
import 'package:meta/meta.dart';

part 'fitness_data_event.dart';
part 'fitness_data_state.dart';

class FitnessDataBloc extends Bloc<FitnessDataEvent, FitnessDataState> {
  final FitnessDataRepository _fitnessDataRepository;
  static int numOfDaysInThePast = 4;

  FitnessDataBloc({@required FitnessDataRepository fitnessDataRepository})
      : assert(fitnessDataRepository != null),
        _fitnessDataRepository = fitnessDataRepository;

  @override
  FitnessDataState get initialState => FitnessDataNotLoaded();

  @override
  Stream<FitnessDataState> mapEventToState(
    FitnessDataEvent event,
  ) async* {
    if (event is LoadFitnessData) {
      yield* _mapLoadingToState(event);
    }

    if (event is SetDateSelected) {
      yield* _mapSetDateSelectedToState(event);
    }
  }

  Stream<FitnessDataState> _mapLoadingToState(LoadFitnessData event) async* {
    try {
      final fitnessData = _fitnessDataRepository.retrieve(event.startDateTime);
      yield FitnessDataLoaded(fitnessData, Jiffy().startOf(Units.DAY));
    } catch (_) {
      yield FitnessDataNotLoaded();
    }
  }

  Stream<FitnessDataState> _mapSetDateSelectedToState(
      SetDateSelected event) async* {
    try {
      yield FitnessDataLoaded(this.state.props.first, event._dateSelected);
    } catch (_) {
      yield FitnessDataNotLoaded();
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
