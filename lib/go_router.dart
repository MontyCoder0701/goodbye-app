import 'package:go_router/go_router.dart';

import 'main_scaffold.dart';
import 'screens/lost_person_detail.dart';
import 'screens/media_memory_detail.dart';
import 'screens/memories.dart';
import 'screens/memory_detail.dart';
import 'screens/written_memory_detail.dart';

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
            final openModalOnLoad =
                state.uri.queryParameters['open_modal'] == 'true';
            return MemoryDetailScreen(
              lostPersonId: lostPersonId,
              openModalOnLoad: openModalOnLoad,
            );
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
