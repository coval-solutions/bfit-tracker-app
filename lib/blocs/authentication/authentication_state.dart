part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class Uninitialized extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final CovalUser _user;

  const Authenticated(this._user);

  @override
  List<Object> get props => [this._user];

  @override
  String toString() => "Authenticated { uid: ${this._user.getUid()} }";
}

class Unauthenticated extends AuthenticationState {}
