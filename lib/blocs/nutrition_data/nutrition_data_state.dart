part of 'nutrition_data_bloc.dart';

abstract class NutritionDataState extends Equatable {
  const NutritionDataState();

  @override
  List<Object> get props => [];
}

class NutritionDataNotLoaded extends NutritionDataState {}

class NutritionDataLoaded extends NutritionDataState {
  final Future<List<NutrientStat>> _stats;
  final DateTime _dateSelected;

  const NutritionDataLoaded(stats, dateSelected)
      : assert(stats != null && dateSelected != null),
        _stats = stats,
        _dateSelected = dateSelected;

  @override
  List<Object> get props => [this._stats, this._dateSelected];

  @override
  String toString() =>
      "NutritionDataLoaded { stats: ${this._stats} dateSelected: ${this._dateSelected} }";
}

class NutritionDataLoading extends NutritionDataState {}
