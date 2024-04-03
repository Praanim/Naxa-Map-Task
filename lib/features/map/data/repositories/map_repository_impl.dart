import 'package:map_task/features/map/data/datasources/map_data_source.dart';
import 'package:map_task/features/map/domain/models/location_model.dart';
import 'package:map_task/features/map/domain/repositories/map_repository.dart';

class MapRepositoryImpl implements MapRepository {
  final MapDataSource mapDataSource;

  MapRepositoryImpl({required this.mapDataSource});

  @override
  Future<List<LocationModel>?> getAllLocations() {
    return mapDataSource.getLocationDetails();
  }
}
