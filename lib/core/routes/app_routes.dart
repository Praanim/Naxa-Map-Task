import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:map_task/core/routes/router_constants.dart';
import 'package:map_task/custom_buttom_navigator.dart';
import 'package:map_task/features/list/presentation/screens/list_main_screen.dart';
import 'package:map_task/features/map/presentation/screens/map_screen.dart';

final GlobalKey<NavigatorState> rootNavigator = GlobalKey();

final GoRouter router = GoRouter(
    navigatorKey: rootNavigator,
    initialLocation: '/list-screen',
    routes: [
      StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) => BottomNavigatorWidget(
                navigationShell,
              ),
          branches: [
            StatefulShellBranch(routes: [
              GoRoute(
                name: RouteConstants.listScreen,
                path: '/list-screen',
                pageBuilder: (context, state) {
                  return const NoTransitionPage(
                    child: MapScreen(),
                  );
                },
              ),
            ]),
            StatefulShellBranch(routes: [
              GoRoute(
                name: RouteConstants.mapScreen,
                path: '/map-screen',
                pageBuilder: (context, state) {
                  return const NoTransitionPage(
                    child: ListMainScreen(),
                  );
                },
              ),
            ]),
          ])
    ]);
