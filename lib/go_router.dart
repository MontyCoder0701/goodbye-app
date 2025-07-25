import 'package:go_router/go_router.dart';

import '/screens/lost_person_detail.dart';
import '/screens/media_memory_detail.dart';
import '/screens/memory_detail.dart';
import '/screens/screen2.dart';
import '/screens/screen3.dart';
import '/screens/written_memory_detail.dart';
import 'main_scaffold.dart';
import 'screens/memories.dart';

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
    GoRoute(
      path: '/lost_person/:lost_person_id',
      builder: (context, state) {
        final lostPersonId = state.pathParameters['lost_person_id']!;
        return LostPersonDetailScreen(lostPersonId: lostPersonId);
      },
      routes: [
        GoRoute(
          path: '/memories',
          builder: (context, state) {
            final lostPersonId = state.pathParameters['lost_person_id']!;
            return MemoryDetailScreen(lostPersonId: lostPersonId);
          },
        ),
        GoRoute(
          path: '/item/:item_id',
          builder: (context, state) {
            final itemId = state.pathParameters['item_id']!;
            final itemType = state.uri.queryParameters['item_type'] ?? '';
            switch (itemType) {
              case 'written':
                return WrittenMemoryDetailPage(itemId: itemId);
              default:
                return MediaMemoryDetailPage(itemId: itemId);
            }
          },
        ),
      ],
    ),
  ],
);
