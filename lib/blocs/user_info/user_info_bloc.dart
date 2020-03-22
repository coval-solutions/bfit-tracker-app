import 'dart:async';

import 'package:bfit_tracker/models/user.dart';
import 'package:bfit_tracker/models/user_info.dart';
import 'package:bfit_tracker/repositories/user_info_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'user_info_event.dart';
part 'user_info_state.dart';

class UserInfoBloc
    extends Bloc<UserInfoEvent, UserInfoState> {
  final User _user;
  final UserInfoRepository _userInfoRepository;

  UserInfoBloc({@required User user, @required UserInfoRepository userInfoRepository})
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
    }
  }

  Stream<UserInfoState> _mapLoadingToState() async* {
    try {
      final userInfo = _userInfoRepository.retrieve(this._user);
      yield UserInfoLoaded(userInfo);
    } catch (_) {
      yield UserInfoNotLoaded();
    }
  }
  
  @override
  Future<void> close() {
    return super.close();
  }
}
