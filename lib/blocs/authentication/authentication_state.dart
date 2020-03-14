import 'package:bfit_tracker/models/user.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthenticationState extends Equatable {
  AuthenticationState([List props = const []]) : super();

  @override
  List<Object> get props => [];
}

class Authenticated extends AuthenticationState {
  final User currentUser;
  final Position currentLocation;

  Authenticated(this.currentUser, this.currentLocation) : super([currentUser, currentLocation]);

  @override
  String toString() => 'Authenticated { email: ${currentUser.email} }';
}

class Unauthenticated extends AuthenticationState {
  @override
  String toString() => 'Unauthenticated';
}