import 'package:bfit_tracker/repos/location_repository.dart';
import 'package:bfit_tracker/repos/user_info_repository.dart';
import 'package:bfit_tracker/repos/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'index.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;
  final UserInfoRepository _userInfoRepository;
  final LocationRepository _locationRepository;

  AuthenticationBloc(
      {@required UserRepository userRepository,
      @required UserInfoRepository userInfoRepository,
      @required LocationRepository locationRepository})
      : assert(userRepository != null, locationRepository != null),
        _userRepository = userRepository,
        _userInfoRepository = userInfoRepository,
        _locationRepository = locationRepository;

  @override
  AuthenticationState get initialState => Unauthenticated();

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
        final currentUser = await _userRepository.getUser();
        final userInfo = await _userInfoRepository.getUserInfo();
        final location = await _locationRepository.getLocation(force: true);
        yield Authenticated(currentUser, userInfo, location);
      } else {
        await _userRepository.signInWithGoogle();
        this.add(AppStarted());
      }
    } catch (error) {
      yield Unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    yield Authenticated(await _userRepository.getUser(),
        await _userInfoRepository.getUserInfo(),
        await _locationRepository.getLocation(force: false));
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    yield Unauthenticated();
    _userRepository.signOut();
  }
}
