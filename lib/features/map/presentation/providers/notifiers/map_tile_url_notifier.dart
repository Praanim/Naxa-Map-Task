import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:map_task/core/constants/constants.dart';

final mapTileUrlNotifierProvider =
    StateNotifierProvider<MaptileUrlNotifier, String>(
        (ref) => MaptileUrlNotifier());

class MaptileUrlNotifier extends StateNotifier<String> {
  MaptileUrlNotifier() : super(Constants.tileUrlLists[0]);

  final listOfMapUrl = Constants.tileUrlLists;

  //cyclically change the map (incremental)
  void changeMap() {
    final currentState = state;
    final currentIndex = listOfMapUrl.indexOf(currentState);
    if (currentIndex != -1) {
      final nextIndex = (currentIndex + 1) % listOfMapUrl.length;
      state = listOfMapUrl[nextIndex];
    }
  }
}
