import 'dart:async';

import 'package:bfit_tracker/models/nutrient_stat.dart';
import 'package:bfit_tracker/repositories/nutrition_data_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:meta/meta.dart';

part 'nutrition_data_event.dart';
part 'nutrition_data_state.dart';

class NutritionDataBloc extends Bloc<NutritionDataEvent, NutritionDataState> {
  final NutritionDataRepository _nutritionDataRepository;
  static int numOfDaysInThePast = 7;

  NutritionDataBloc({@required NutritionDataRepository nutritionDataRepository})
      : assert(nutritionDataRepository != null),
        _nutritionDataRepository = nutritionDataRepository;

  @override
  NutritionDataState get initialState => NutritionDataNotLoaded();

  @override
  Stream<NutritionDataState> mapEventToState(
    NutritionDataEvent event,
  ) async* {
    if (event is LoadNutritionData) {
      yield* _mapLoadingToState(event);
    }

    if (event is SetDateSelected) {
      yield* _mapSetDateSelectedToState(event);
    }
  }

  Stream<NutritionDataState> _mapLoadingToState(
      LoadNutritionData event) async* {
    try {
      final nutritionData = _nutritionDataRepository.retrieve(
          event.startDateTime, event.endDateTime);
      if (this.state.props.isEmpty) {
        yield NutritionDataLoaded(nutritionData, event.startDateTime);
      } else {
        yield NutritionDataLoaded(nutritionData, event.startDateTime);
      }
    } catch (_) {
      yield NutritionDataNotLoaded();
    }
  }

  Stream<NutritionDataState> _mapSetDateSelectedToState(
      SetDateSelected event) async* {
    try {
      yield NutritionDataLoaded(this.state.props.first, event._dateSelected);
    } catch (_) {
      yield NutritionDataNotLoaded();
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
