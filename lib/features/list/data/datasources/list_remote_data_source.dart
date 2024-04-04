import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:map_task/core/exceptions/http_exceptions.dart';
import 'package:map_task/features/list/data/datasources/list_data_source.dart';
import 'package:map_task/features/list/domain/models/list_model.dart';

class ListRemoteDataSource implements ListDataSource {
  final Dio dio;

  ListRemoteDataSource({required this.dio});

  @override
  Future<Either<AppException, List<ListItemModel>>> getListItems() async {
    try {
      final response = await dio.get('https://api.publicapis.org/entries');

      final data = response.data['entries'] as List;

      final listItems =
          data.map((entry) => ListItemModel.fromJson(entry)).toList();

      return Right(listItems);
    } on DioException catch (_) {
      return Left(AppException(
        message: 'Server Exception !!!',
      ));
    } catch (_) {
      return Left(AppException(message: "Something went wrong !!!"));
    }
  }
}
