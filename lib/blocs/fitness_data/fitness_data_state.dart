part of 'fitness_data_bloc.dart';

abstract class FitnessDataState extends Equatable {
  const FitnessDataState();

  @override
  List<Object> get props => [];
}

class FitnessDataNotLoaded extends FitnessDataState {}

class FitnessDataLoaded extends FitnessDataState {
  final Future<List<HealthDataPoint>> _fitnessData;

  const FitnessDataLoaded(this._fitnessData);

  @override
  List<Object> get props => [this._fitnessData];

  @override
  String toString() => "FitnessDataLoaded { fitnessData: ${this._fitnessData} }";
}

class FitnessDataLoading extends FitnessDataState {}