part of 'fitness_data_bloc.dart';

abstract class FitnessDataEvent extends Equatable {
  const FitnessDataEvent();

  @override
  List<Object> get props => [];
}

class LoadFitnessData extends FitnessDataEvent {}