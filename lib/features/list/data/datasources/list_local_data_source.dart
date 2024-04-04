import 'package:dartz/dartz.dart';
import 'package:map_task/core/exceptions/http_exceptions.dart';
import 'package:map_task/core/services/db_services.dart';
import 'package:map_task/features/list/data/datasources/list_data_source.dart';
import 'package:map_task/features/list/domain/models/list_model.dart';

class ListLocalDataSource implements ListDataSource {
  final LocalDbServices localDbServices;

  ListLocalDataSource({required this.localDbServices});

  @override
  Future<Either<AppException, List<ListItemModel>>> getListItems() async {
    try {
      final listItemsMaps = await localDbServices.readListItemsFromDb();

      //if the values from local db is empty then we return empty
      if (listItemsMaps.isEmpty) {
        return const Right([]);
      }

      final listItems = listItemsMaps
          .map((listItemJson) => ListItemModel.fromDb(listItemJson))
          .toList();

      return Right(listItems);
    } catch (e) {
      return Left(AppException(message: 'Failed to get items from Db'));
    }
  }

  Future<Either<AppException, String>> insertListItemsToDb(
      List<ListItemModel> listItems) async {
    try {
      await localDbServices.insertLists(listItems);
      return const Right('Items added to Db');
    } catch (e) {
      return Left(AppException(message: 'Failed to add items to Db'));
    }
  }
}
