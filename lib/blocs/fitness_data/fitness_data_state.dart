part of 'fitness_data_bloc.dart';

abstract class FitnessDataState extends Equatable {
  const FitnessDataState();

  @override
  List<Object> get props => [];
}

class FitnessDataNotLoaded extends FitnessDataState {}

class FitnessDataLoaded extends FitnessDataState {
  final Future<Map<HealthDataType, Map>> _stats;
  final DateTime _dateSelected;

  const FitnessDataLoaded(stats, dateSelected)
      : assert(stats != null && dateSelected != null),
        _stats = stats,
        _dateSelected = dateSelected;

  @override
  List<Object> get props => [this._stats, this._dateSelected];

  @override
  String toString() =>
      "FitnessDataLoaded { stats: ${this._stats} dateSelected: ${this._dateSelected} }";
}

class FitnessDataLoading extends FitnessDataState {}
