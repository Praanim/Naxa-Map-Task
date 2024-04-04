import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_task/core/extensions/context_extension.dart';
import 'package:map_task/features/map/presentation/providers/notifiers/map_state_notifier.dart';
import 'package:map_task/features/map/presentation/providers/states/map_state.dart';

class MapBody extends StatefulWidget {
  final Position? currentPosition;

  const MapBody({super.key, this.currentPosition});

  @override
  State<MapBody> createState() => _MapBodyState();
}

class _MapBodyState extends State<MapBody> {
  late MapController _mapController;
  List<Marker> markers = [];
  final LatLng _defaultPositon = const LatLng(27.717245, 85.323959);

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialZoom: 4,
          initialCenter: _defaultPositon,
        ),
        children: [
          TileLayer(
            // urlTemplate:
            //     'https://tile.thunderforest.com/atlas/{z}/{x}/{y}.png?apikey=b037f9afdeb84b2d9b57b93e057619b5',
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          ),
          Consumer(builder: (context, ref, child) {
            final mapState = ref.watch(mapStateNotifierProvider);

            //state notifier listener
            _mapStateListener(ref, context);
            if (mapState is MapLoaded) {
              _addLocationsToMap(mapState, context);
            }
            return MarkerLayer(
              markers: [
                ...markers,
                if (widget.currentPosition != null)
                  Marker(
                    point: LatLng(widget.currentPosition!.latitude,
                        widget.currentPosition!.longitude),
                    width: 100,
                    height: 100,
                    child: const Icon(
                      Icons.home_outlined,
                      color: Colors.green,
                    ),
                  )
              ],
            );
          }),
        ],
      ),
    );
  }

  void _addLocationsToMap(MapLoaded mapState, BuildContext context) {
    //add all locations with marker  to the map
    markers.addAll(mapState.locations
        .map((locationModel) => Marker(
              point: LatLng(locationModel.latY, locationModel.longx),
              width: 100,
              height: 100,
              child: IconButton(
                  onPressed: () {
                    _mapController.move(
                        LatLng(locationModel.latY, locationModel.longx), 7);

                    //show bottom sheet containing details
                    context.showBottomSheet(locationModel);
                  },
                  icon: const Icon(
                    Icons.my_location_rounded,
                    color: Colors.red,
                  )),
            ))
        .toList());
  }

  void _mapStateListener(WidgetRef ref, BuildContext context) {
    ref.listen(mapStateNotifierProvider, (previous, next) {
      if (next is MapFailure) {
        context.showSnackBar(message: next.message, toastType: ToastType.error);
      }
      if (next is MapLoaded) {
        context.showSnackBar(
            message: "All location markers added",
            toastType: ToastType.success);
      }
    });
  }
}
