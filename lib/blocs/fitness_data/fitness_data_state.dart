part of 'fitness_data_bloc.dart';

abstract class FitnessDataState extends Equatable {
  const FitnessDataState();

  @override
  List<Object> get props => [];
}

class FitnessDataNotLoaded extends FitnessDataState {}

class FitnessDataLoaded extends FitnessDataState {
  final Future<Stats> _stats;
  final DateTime _startDateTime;

  const FitnessDataLoaded(this._stats, this._startDateTime);

  @override
  List<Object> get props => [this._stats, _startDateTime];

  @override
  String toString() => "FitnessDataLoaded { stats: ${this._stats}, startTime: ${this._startDateTime} }";
}

class FitnessDataLoading extends FitnessDataState {}