import 'package:map_task/features/map/domain/models/location_model.dart';

abstract class MapState {}

class MapInitial extends MapState {}

class MapLoading extends MapState {}

class MapLoaded extends MapState {
  final List<LocationModel> locations;

  MapLoaded({required this.locations});
}

class MapFailure extends MapState {
  final String message;

  MapFailure({required this.message});
}
