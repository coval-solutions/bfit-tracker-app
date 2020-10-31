import 'dart:async';

import 'package:bfit_tracker/models/coval_user.dart';
import 'package:bfit_tracker/models/user_info.dart';
import 'package:bfit_tracker/repositories/user_info_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'user_info_event.dart';
part 'user_info_state.dart';

class UserInfoBloc extends Bloc<UserInfoEvent, UserInfoState> {
  final CovalUser _user;
  final UserInfoRepository _userInfoRepository;

  UserInfoBloc(
      {@required CovalUser user,
      @required UserInfoRepository userInfoRepository})
      : assert(user != null && userInfoRepository != null),
        _user = user,
        _userInfoRepository = userInfoRepository;

  @override
  UserInfoState get initialState => UserInfoLoading();

  @override
  Stream<UserInfoState> mapEventToState(
    UserInfoEvent event,
  ) async* {
    if (event is LoadUserInfo) {
      yield* _mapLoadingToState();
    } else if (event is CreateUserInfo) {
      yield* _mapCreateToState(event);
    } else if (event is UpdateUserInfo) {
      yield* _mapUpdateToState(event);
    }
  }

  Stream<UserInfoState> _mapLoadingToState() async* {
    try {
      final userInfo = _userInfoRepository.retrieve(this._user);
      yield UserInfoLoaded(userInfo);
    } catch (_) {
      print(_);
      yield UserInfoNotLoaded();
    }
  }

  Stream<UserInfoState> _mapCreateToState(CreateUserInfo event) async* {
    await _userInfoRepository.create(this._user, event._userInfo);
  }

  Stream<UserInfoState> _mapUpdateToState(UpdateUserInfo event) async* {
    await _userInfoRepository.update(this._user, event._userInfo);
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
