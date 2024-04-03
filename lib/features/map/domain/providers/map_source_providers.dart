import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:map_task/core/providers/dio_provider.dart';
import 'package:map_task/features/map/data/datasources/map_data_source.dart';
import 'package:map_task/features/map/data/repositories/map_repository_impl.dart';
import 'package:map_task/features/map/domain/repositories/map_repository.dart';

final mapDataSourceProvider = Provider<MapDataSource>(
  (ref) => MapRemoteDataSource(dio: ref.watch(dioProvider)),
);

final mapRepositoryProvider = Provider<MapRepository>((ref) =>
    MapRepositoryImpl(mapDataSource: ref.watch(mapDataSourceProvider)));
