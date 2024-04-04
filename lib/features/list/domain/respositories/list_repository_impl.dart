import 'package:dartz/dartz.dart';
import 'package:map_task/core/exceptions/http_exceptions.dart';
import 'package:map_task/features/list/data/datasources/list_local_data_source.dart';
import 'package:map_task/features/list/data/datasources/list_remote_data_source.dart';
import 'package:map_task/features/list/data/repositories/list_repository.dart';
import 'package:map_task/features/list/domain/models/list_model.dart';

class ListRepositoryImpl extends ListRepository {
  final ListRemoteDataSource listRemoteDataSource;

  final ListLocalDataSource listLocalDataSource;

  ListRepositoryImpl(
      {required this.listLocalDataSource, required this.listRemoteDataSource});

  @override
  Future<Either<AppException, List<ListItemModel>>> getListItems(
      bool fromLocal) {
    if (fromLocal) {
      return listLocalDataSource.getListItems();
    } else {
      return listRemoteDataSource.getListItems();
    }
  }

  @override
  Future<Either<AppException, void>> insertListItemsToDb(
      List<ListItemModel> listItems) {
    return listLocalDataSource.insertListItemsToDb(listItems);
  }
}
