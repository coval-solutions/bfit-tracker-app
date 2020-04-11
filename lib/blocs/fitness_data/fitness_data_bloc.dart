import 'dart:async';

import 'package:bfit_tracker/models/stats.dart';
import 'package:bfit_tracker/repositories/fitness_data_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'fitness_data_event.dart';
part 'fitness_data_state.dart';

class FitnessDataBloc
    extends Bloc<FitnessDataEvent, FitnessDataState> {
  final FitnessDataRepository _fitnessDataRepository;

  FitnessDataBloc({@required FitnessDataRepository fitnessDataRepository})
      : assert(fitnessDataRepository != null),
        _fitnessDataRepository = fitnessDataRepository;

  @override
  FitnessDataState get initialState => FitnessDataLoading();

  @override
  Stream<FitnessDataState> mapEventToState(
    FitnessDataEvent event,
  ) async* {
    if (event is LoadFitnessData) {
      yield* _mapLoadingToState(event);
    }
  }

  Stream<FitnessDataState> _mapLoadingToState(LoadFitnessData event) async* {
    try {
      final fitnessData = _fitnessDataRepository.retrieve(event._startDateTime);
      yield FitnessDataLoaded(fitnessData, event._startDateTime);
    } catch (_) {
      yield FitnessDataNotLoaded();
    }
  }
  
  @override
  Future<void> close() {
    return super.close();
  }
}
