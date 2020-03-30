import 'dart:async';

import 'package:bfit_tracker/models/gym.dart';
import 'package:bfit_tracker/repositories/gym_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

part 'gym_event.dart';
part 'gym_state.dart';

class GymBloc
    extends Bloc<GymEvent, GymState> {
  final Position _position;
  final GymRepository _gymRepository;

  GymBloc({@required Position position, @required GymRepository gymRepository})
      : assert(position != null && gymRepository != null),
        _position = position,
        _gymRepository = gymRepository;

  @override
  GymState get initialState => GymLoading();

  @override
  Stream<GymState> mapEventToState(
    GymEvent event,
  ) async* {
    if (event is LoadGym) {
      yield* _mapLoadingToState();
    }
  }

  Stream<GymState> _mapLoadingToState() async* {
    try {
      final gyms = _gymRepository.retrieve(this._position);
      yield GymLoaded(gyms);
    } catch (_) {
      yield GymNotLoaded();
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
