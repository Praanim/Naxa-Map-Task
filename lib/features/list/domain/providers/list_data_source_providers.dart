import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:map_task/core/providers/db_services_provider.dart';
import 'package:map_task/core/providers/dio_provider.dart';
import 'package:map_task/features/list/data/datasources/list_local_data_source.dart';
import 'package:map_task/features/list/data/datasources/list_remote_data_source.dart';
import 'package:map_task/features/list/data/repositories/list_repository.dart';
import 'package:map_task/features/list/domain/respositories/list_repository_impl.dart';

final listRemoteDataSourceProvider = Provider<ListRemoteDataSource>(
    (ref) => ListRemoteDataSource(dio: ref.watch(dioProvider)));

final listLocalDataSourceProvider = Provider<ListLocalDataSource>((ref) =>
    ListLocalDataSource(localDbServices: ref.watch(dbServicesProvider)));

final listRepositoryProvider = Provider<ListRepository>(
  (ref) => ListRepositoryImpl(
      listLocalDataSource: ref.watch(listLocalDataSourceProvider),
      listRemoteDataSource: ref.watch(listRemoteDataSourceProvider)),
);
