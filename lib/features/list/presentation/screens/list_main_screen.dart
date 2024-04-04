import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:map_task/core/extensions/context_extension.dart';
import 'package:map_task/core/services/url_launcher_services.dart';
import 'package:map_task/features/list/presentation/providers/list_notifier.dart';
import 'package:map_task/features/list/presentation/providers/list_state.dart';
import 'package:map_task/features/list/presentation/widgets/custom_error_widget.dart';
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
        //url launcher listener
        _urlLauncherListener(ref, context);

        //list state listener
        _listStateListener(ref, context);
        final listState = ref.watch(listStateNotifierProvider);
        if (listState is ListLoading) {
          return const LoadingWidget();
        } else if (listState is ListLoaded) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: RefreshIndicator(
              onRefresh: () async {
                _onRefresh(ref);
              },
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
                          ref
                              .read(urlLauncherNotifierProvider.notifier)
                              .tryLaunchUrl(listItem.link);
                        },
                      ),
                    );
                  },
                  itemCount: listState.listItemModel.length),
            ),
          );
        } else if (listState is ListError) {
          return CustomErrorWidget(
            text: listState.message,
            onRefresh: () async {
              _onRefresh(ref);
            },
          );
        }
        return CustomErrorWidget(
          text: 'We are working on this.',
          onRefresh: () async {
            _onRefresh(ref);
          },
        );
      }),
    );
  }

  void _onRefresh(WidgetRef ref) {
    ref.invalidate(listStateNotifierProvider);
  }

  void _urlLauncherListener(WidgetRef ref, BuildContext context) {
    ref.listen(
      urlLauncherNotifierProvider,
      (previous, next) {
        if (next != null) {
          context.showSnackBar(
              message: next.message, toastType: ToastType.error);
        }
      },
    );
  }

  void _listStateListener(WidgetRef ref, BuildContext context) {
    ref.listen(listStateNotifierProvider, (previous, next) {
      if (next is ListLoaded) {
        context.showSnackBar(
            message: "Data Loaded from ${next.datasource.name} server",
            toastType: ToastType.success);
      }
    });
  }
}
