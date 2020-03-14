import 'package:bfit_tracker/repos/location_repository.dart';
import 'package:bfit_tracker/repos/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'index.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;
  final LocationRepository _locationRepository;

  AuthenticationBloc({@required UserRepository userRepository, @required LocationRepository locationRepository})
      : assert(userRepository != null, locationRepository != null),
        _userRepository = userRepository,
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
        final location = await _locationRepository.getLocation(force: true);
        yield Authenticated(currentUser, location);
      } else {
        await _userRepository.signInWithGoogle();
        this.add(AppStarted());
      }
    } catch (error) {
      yield Unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    yield Authenticated(await _userRepository.getUser(), await _locationRepository.getLocation(force: false));
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    yield Unauthenticated();
    _userRepository.signOut();
  }
}