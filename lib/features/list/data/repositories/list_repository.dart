import 'package:dartz/dartz.dart';
import 'package:map_task/core/exceptions/http_exceptions.dart';
import 'package:map_task/features/list/domain/models/list_model.dart';

abstract class ListRepository {
  Future<Either<AppException, List<ListItemModel>>> getListItems();
}
