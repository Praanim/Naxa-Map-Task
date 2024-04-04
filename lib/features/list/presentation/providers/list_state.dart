import 'package:map_task/features/list/domain/models/list_model.dart';

enum Datasource { remote, local }

abstract class ListState {}

class ListLoading extends ListState {}

class ListLoaded extends ListState {
  final Datasource datasource;
  final List<ListItemModel> listItemModel;

  ListLoaded({required this.datasource, required this.listItemModel});
}

class ListError extends ListState {
  final String message;

  ListError({required this.message});
}
