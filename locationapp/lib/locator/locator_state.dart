part of 'locator_bloc.dart';

@immutable
abstract class LocatorState {}

class LocatorInitial extends LocatorState {}

class FetchingLocationState extends LocatorState {}

class LocatedState extends LocatorState {
  final double lat;
  final double lng;
  final String cityName;
  LocatedState({
    required this.lat,
    required this.lng,
    required this.cityName
  });
}
