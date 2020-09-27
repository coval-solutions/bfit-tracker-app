import 'dart:async';

import 'package:bfit_tracker/models/coval_user.dart';
import 'package:bfit_tracker/repositories/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;

  AuthenticationBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  AuthenticationState get initialState => Uninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    try {
      final isSignedIn = await _userRepository.isSignedIn();
      if (isSignedIn) {
        final CovalUser user =
            this._userFromFirebaseUser(_userRepository.getUser());
        yield Authenticated(user);
      } else {
        await this._userRepository.signInWithGoogle();
        this.add(LoggedIn());
      }
    } catch (_) {
      print(_);
      yield Unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    final User firebaseUser = await _userRepository.getUser();
    final CovalUser user = this._userFromFirebaseUser(firebaseUser);
    yield Authenticated(user);
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    yield Unauthenticated();
    _userRepository.signOut();
  }

  CovalUser _userFromFirebaseUser(User firebaseUser) {
    return firebaseUser != null
        ? CovalUser(
            firebaseUser.uid,
            firebaseUser.email,
            firebaseUser.displayName,
            CovalUser.getImageFromUrl(firebaseUser.photoURL))
        : null;
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
