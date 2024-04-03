import 'package:map_task/features/map/domain/models/location_model.dart';

abstract class MapRepository {
  Future<List<LocationModel>?> getAllLocations();
}
