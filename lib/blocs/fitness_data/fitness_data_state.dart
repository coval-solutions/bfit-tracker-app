part of 'fitness_data_bloc.dart';

abstract class FitnessDataState extends Equatable {
  const FitnessDataState();

  @override
  List<Object> get props => [];
}

class FitnessDataNotLoaded extends FitnessDataState {}

class FitnessDataLoaded extends FitnessDataState {
  final Future<Stats> _stats;

  const FitnessDataLoaded(this._stats);

  @override
  List<Object> get props => [this._stats];

  @override
  String toString() => "FitnessDataLoaded { stats: ${this._stats} }";
}

class FitnessDataLoading extends FitnessDataState {}