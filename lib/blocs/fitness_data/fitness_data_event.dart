part of 'fitness_data_bloc.dart';

abstract class FitnessDataEvent extends Equatable {
  const FitnessDataEvent();

  @override
  List<Object> get props => [];
}

class LoadFitnessData extends FitnessDataEvent {
  final DateTime _startDateTime;

  LoadFitnessData(this._startDateTime);

  @override
  List<Object> get props => [this._startDateTime];

  @override
  String toString() => "LoadFitnessData { startDateTime: ${this._startDateTime} }";
}