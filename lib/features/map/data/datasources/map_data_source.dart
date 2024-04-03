import 'package:dio/dio.dart';
import 'package:map_task/features/map/domain/models/location_model.dart';

abstract class MapDataSource {
  Future<List<LocationModel>?> getLocationDetails();
}

class MapRemoteDataSource implements MapDataSource {
  final Dio dio;

  MapRemoteDataSource({required this.dio});

  @override
  Future<List<LocationModel>?> getLocationDetails() async {
    try {
      final response = await dio.get(
          'https://d2ad6b4ur7yvpq.cloudfront.net/naturalearth-3.3.0/ne_50m_geography_regions_points.geojson');
      final data = response.data['features'] as List;

      return data
          .map((locationJson) =>
              LocationModel.fromJson(locationJson['properties']))
          .toList();
    } catch (e) {
      print("Something went wrong : $e");
      return null;
    }
  }
}
