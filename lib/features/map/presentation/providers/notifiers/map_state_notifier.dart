import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:map_task/features/map/domain/providers/map_source_providers.dart';
import 'package:map_task/features/map/domain/repositories/map_repository.dart';
import 'package:map_task/features/map/presentation/providers/states/map_state.dart';

///map state notifier provider
final mapStateNotifierProvider =
    StateNotifierProvider<MapStateNotifier, MapState>((ref) =>
        MapStateNotifier(ref.watch(mapRepositoryProvider))
          ..getAllLocationDetails());

class MapStateNotifier extends StateNotifier<MapState> {
  final MapRepository mapRepository;

  MapStateNotifier(this.mapRepository) : super(MapInitial());

  ///gets locations/details from the server.
  void getAllLocationDetails() async {
    state = MapLoading();
    final locations = await mapRepository.getAllLocations();
    if (locations != null) {
      state = MapLoaded(locations: locations);
    } else {
      state = MapFailure(message: "Could not get locations from the server");
    }
  }
}
