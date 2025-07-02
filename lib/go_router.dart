import 'package:flutter_starter/screens/memories.dart';
import 'package:flutter_starter/screens/screen2.dart';
import 'package:flutter_starter/screens/screen3.dart';
import 'package:go_router/go_router.dart';

import 'main_scaffold.dart';

final goRouter = GoRouter(
  initialLocation: '/memories',
  routes: [
    ShellRoute(
      builder: (context, state, child) => MainScaffold(child: child),
      routes: [
        GoRoute(
          path: '/memories',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: MemoriesScreen()),
        ),
        GoRoute(
          path: '/screen2',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: Screen2()),
        ),
        GoRoute(
          path: '/screen3',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: Screen3()),
        ),
      ],
    ),
  ],
);
