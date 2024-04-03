import 'package:geolocator/geolocator.dart';

abstract class CurrentLocationState {}

class CurrentLocationLoading extends CurrentLocationState {}

class CurrentLocationLoaded extends CurrentLocationState {
  final Position position;

  CurrentLocationLoaded({required this.position});
}

class CurrentLocationError extends CurrentLocationState {
  final String message;

  CurrentLocationError({required this.message});
}
