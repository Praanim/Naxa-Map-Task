import 'package:dartz/dartz.dart';
import 'package:map_task/core/exceptions/http_exceptions.dart';
import 'package:map_task/features/list/data/datasources/list_remote_data_source.dart';
import 'package:map_task/features/list/data/repositories/list_repository.dart';
import 'package:map_task/features/list/domain/models/list_model.dart';

class ListRepositoryImpl extends ListRepository {
  final ListRemoteDataSource listRemoteDataSource;

  ListRepositoryImpl({required this.listRemoteDataSource});

  @override
  Future<Either<AppException, List<ListItemModel>>> getListItems() {
    return listRemoteDataSource.getListItems();
  }
}
