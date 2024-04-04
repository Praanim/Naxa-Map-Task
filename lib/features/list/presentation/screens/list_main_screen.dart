import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:map_task/features/list/presentation/providers/list_notifier.dart';
import 'package:map_task/features/list/presentation/providers/list_state.dart';
import 'package:map_task/features/list/presentation/widgets/loading_widget.dart';

class ListMainScreen extends StatelessWidget {
  const ListMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ListView',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Consumer(builder: (context, ref, child) {
        final listState = ref.watch(listStateNotifierProvider);
        if (listState is ListLoading) {
          return const LoadingWidget();
        } else if (listState is ListLoaded) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ListView.builder(
                itemBuilder: (context, index) {
                  //individual list item
                  final listItem = listState.listItemModel[index];
                  return Card(
                    child: ListTile(
                      title: Text(listItem.api),
                      subtitle: Text(listItem.description),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      ),
                      onTap: () async {
                        try {} catch (e) {
                          print(e.toString());
                        }
                      },
                    ),
                  );
                },
                itemCount: listState.listItemModel.length),
          );
        } else if (listState is ListError) {
          return CustomErrorWidget(text: listState.message);
        }
        return const CustomErrorWidget(
          text: 'We are working on this.',
        );
      }),
    );
  }
}

class CustomErrorWidget extends StatelessWidget {
  final String text;

  const CustomErrorWidget({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(text),
    );
  }
}
