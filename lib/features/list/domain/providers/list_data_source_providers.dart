import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:map_task/core/providers/dio_provider.dart';
import 'package:map_task/features/list/data/datasources/list_remote_data_source.dart';
import 'package:map_task/features/list/data/repositories/list_repository.dart';
import 'package:map_task/features/list/domain/respositories/list_repository_impl.dart';

final listRemoteDataSourceProvider = Provider<ListRemoteDataSource>(
    (ref) => ListRemoteDataSource(dio: ref.watch(dioProvider)));

// final listLocalDataSourceProvider = Provider<ListLo>((ref) => )

final listRepositoryProvider = Provider<ListRepository>(
  (ref) => ListRepositoryImpl(
      listRemoteDataSource: ref.watch(listRemoteDataSourceProvider)),
);
