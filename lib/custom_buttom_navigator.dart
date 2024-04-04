import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BottomNavigatorWidget extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;

  //Bottom navigation screen to be displayed.
  BottomNavigatorWidget(
    this.navigationShell, {
    super.key,
  });

  //Bottom navigation bar items.
  final List<BottomNavigationBarItem> _items = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.list),
      label: 'List',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.map_rounded),
      label: 'Map',
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: navigationShell.currentIndex,
        onTap: (value) {
          _onTap(context, value);
        },
        items: _items,
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
