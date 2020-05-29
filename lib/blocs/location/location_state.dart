part of 'location_bloc.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

class Uninitialized extends LocationState {}

class Located extends LocationState {
  final Position _position;

  const Located(this._position);

  @override
  List<Object> get props => [this._position];

  @override
  String toString() => "Located { position: ${this._position} }";
}

class Locating extends LocationState {}
