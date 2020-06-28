import 'dart:async';

import 'package:bfit_tracker/repositories/location_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationRepository _locationRepository;

  LocationBloc({@required LocationRepository locationRepository})
      : assert(locationRepository != null),
        _locationRepository = locationRepository;

  @override
  LocationState get initialState => Uninitialized();

  @override
  Stream<LocationState> mapEventToState(
    LocationEvent event,
  ) async* {
    if (event is Requested) {
      yield* _mapRequestedToState();
    }
  }

  Stream<LocationState> _mapRequestedToState() async* {
    try {
      Position position = await _locationRepository.retrieve();
      yield Located(position);
    } catch (_) {
      yield LocationError();
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
