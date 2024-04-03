import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:map_task/core/extensions/context_extension.dart';
import 'package:map_task/features/map/presentation/providers/notifiers/current_location_notifier.dart';
import 'package:map_task/features/map/presentation/providers/states/current_location_state.dart';

import 'package:map_task/features/map/presentation/screens/map_body.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Map Integration"),
      ),
      body: Consumer(builder: (context, ref, child) {
        final currentPositionState = ref.watch(currentLocationNotifierProvider);
        //current location listener
        _currentLocationListener(ref, context);
        return MapBody(
          currentPosition: currentPositionState is CurrentLocationLoaded
              ? currentPositionState.position
              : null,
        );
      }),
    );
  }

  void _currentLocationListener(WidgetRef ref, BuildContext context) {
    ref.listen(
      currentLocationNotifierProvider,
      (previous, next) {
        if (next is CurrentLocationError) {
          context.showSnackBar(
              message: next.message, toastType: ToastType.error);
        }
      },
    );
  }
}
