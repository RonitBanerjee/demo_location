import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

part 'locator_event.dart';
part 'locator_state.dart';

class LocatorBloc extends Bloc<LocatorEvent, LocatorState> {
  LocatorBloc() : super(LocatorInitial()) {
    on<LocatorClickedEvent>(getUserLocation);
  }

  FutureOr<void> getUserLocation(
      LocatorClickedEvent event, Emitter<LocatorState> emit) async {
    emit(FetchingLocationState());
    late String _currentLocation;
    late String cityName;
    late double latitude;
    late double longitude;

    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      _currentLocation = 'Location services are disabled.';
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _currentLocation = 'Location permissions are denied';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _currentLocation = 'Location permissions are permanently denied';
    }

    try {
      Position position = await Geolocator.getCurrentPosition();

      latitude = position.latitude;
      longitude = position.longitude;

      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        cityName = placemarks.first.locality ?? 'Unknown City';
      } else {
        cityName = 'City not found';
      }
    } catch (e) {
      _currentLocation = 'Failed to get location: $e';
    }

    emit(
      LocatedState(
        lat: latitude,
        lng: longitude,
        cityName: cityName,
      ),
    );
  }
}
