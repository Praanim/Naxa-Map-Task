import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:map_task/features/list/data/repositories/list_repository.dart';
import 'package:map_task/features/list/domain/models/list_model.dart';
import 'package:map_task/features/list/domain/providers/list_data_source_providers.dart';
import 'package:map_task/features/list/presentation/providers/list_state.dart';

final listStateNotifierProvider =
    StateNotifierProvider<ListStateNotifier, ListState>((ref) =>
        ListStateNotifier(ref.watch(listRepositoryProvider))
          ..getAllListItems());

class ListStateNotifier extends StateNotifier<ListState> {
  final ListRepository listRepository;

  ListStateNotifier(this.listRepository) : super(ListLoading());

  ///cached list of listitems
  List<ListItemModel> _listItemModel = [];

  ///method to get listItems
  void getAllListItems() async {
    final eitherResponse = await listRepository.getListItems(true);

    eitherResponse.fold((appException) {
      state = ListError(message: appException.message);
    }, (listItems) async {
      //if the list from local db is not there then we fetch from network
      if (listItems.isEmpty) {
        //req to the server
        final eitherResponse = await listRepository.getListItems(false);

        //either response from network
        eitherResponse.fold((appException) {
          state = ListError(message: appException.message);
        }, (listItems) {
          state = _emitItemLoadedState(listItems, Datasource.remote);
          addListItemsToDb();
        });
      } else {
        state = _emitItemLoadedState(listItems, Datasource.local);
      }
    });
  }

  ListLoaded _emitItemLoadedState(
      List<ListItemModel> listItems, Datasource datasource) {
    //initialize cached listItems
    _listItemModel = listItems;

    return ListLoaded(datasource: datasource, listItemModel: listItems);
  }

  //add list items to Db
  void addListItemsToDb() async {
    final eitherResponse =
        await listRepository.insertListItemsToDb(_listItemModel);

    eitherResponse.fold((appException) {
      state = ListError(message: appException.message);
    }, (_) {
      state = _emitItemLoadedState(_listItemModel, Datasource.local);
    });
  }
}
