part of 'user_info_bloc.dart';

abstract class UserInfoState extends Equatable {
  const UserInfoState();

  @override
  List<Object> get props => [];
}

class UserInfoNotLoaded extends UserInfoState {}

class UserInfoLoaded extends UserInfoState {
  final Stream<UserInfo> _userInfo;

  const UserInfoLoaded(this._userInfo);

  @override
  List<Object> get props => [this._userInfo];

  @override
  String toString() => "UserInfoLoaded { userInfo: ${this._userInfo} }";
}

class UserInfoLoading extends UserInfoState {}
