import 'package:map_task/features/list/domain/models/list_model.dart';

abstract class ListState {}

class ListLoading extends ListState {}

class ListLoaded extends ListState {
  final List<ListItemModel> listItemModel;

  ListLoaded({required this.listItemModel});
}

class ListError extends ListState {
  final String message;

  ListError({required this.message});
}
