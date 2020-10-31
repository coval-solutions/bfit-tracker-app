part of 'user_info_bloc.dart';

abstract class UserInfoEvent extends Equatable {
  const UserInfoEvent();

  @override
  List<Object> get props => [];
}

class LoadUserInfo extends UserInfoEvent {}

class CreateUserInfo extends UserInfoEvent {
  final UserInfo _userInfo;

  CreateUserInfo(this._userInfo);

  @override
  List<Object> get props => [this._userInfo];

  @override
  String toString() => "CreateUserInfo { userInfo: ${this._userInfo} }";
}

class UpdateUserInfo extends UserInfoEvent {
  final UserInfo _userInfo;

  UpdateUserInfo(this._userInfo);

  @override
  List<Object> get props => [this._userInfo];

  @override
  String toString() => "UpdateUserInfo { userInfo: ${this._userInfo} }";
}
