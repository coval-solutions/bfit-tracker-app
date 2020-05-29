part of 'gym_bloc.dart';

abstract class GymState extends Equatable {
  const GymState();

  @override
  List<Object> get props => [];
}

class GymNotLoaded extends GymState {}

class GymLoaded extends GymState {
  final Future<List<Gym>> _gyms;

  const GymLoaded(this._gyms);

  @override
  List<Object> get props => [this._gyms];

  @override
  String toString() => "GymLoaded { _gyms: ${this._gyms} }";
}

class GymLoading extends GymState {}
