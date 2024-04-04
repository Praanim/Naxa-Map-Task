import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:map_task/features/list/data/repositories/list_repository.dart';
import 'package:map_task/features/list/domain/providers/list_data_source_providers.dart';
import 'package:map_task/features/list/presentation/providers/list_state.dart';

final listStateNotifierProvider =
    StateNotifierProvider<ListStateNotifier, ListState>((ref) =>
        ListStateNotifier(ref.watch(listRepositoryProvider))
          ..getAllListItems());

class ListStateNotifier extends StateNotifier<ListState> {
  final ListRepository listRepository;

  ListStateNotifier(this.listRepository) : super(ListLoading());

  ///method to get listItems
  void getAllListItems() async {
    final eitherResponse = await listRepository.getListItems();

    state = eitherResponse.fold(
        (appException) => ListError(message: appException.message),
        (listItems) => ListLoaded(listItemModel: listItems));
  }
}
