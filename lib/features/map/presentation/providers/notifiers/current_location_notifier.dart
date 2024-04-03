import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:map_task/core/services/location_services.dart';
import 'package:map_task/features/map/presentation/providers/states/current_location_state.dart';

final currentLocationNotifierProvider =
    StateNotifierProvider<CurrentLocationNotifier, CurrentLocationState>(
        (ref) => CurrentLocationNotifier()..getCurrentLocationOfUser());

class CurrentLocationNotifier extends StateNotifier<CurrentLocationState> {
  CurrentLocationNotifier() : super(CurrentLocationLoading());

  void getCurrentLocationOfUser() async {
    try {
      final position = await LocationServices.determinePosition();
      state = CurrentLocationLoaded(position: position);
    } catch (e) {
      state = CurrentLocationError(message: e.toString());
    }
  }
}
