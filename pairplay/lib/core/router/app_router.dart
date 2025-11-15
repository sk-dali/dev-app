import 'package:go_router/go_router.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/talk/presentation/talk_screen.dart';
import '../../features/mission/presentation/mission_category_screen.dart';
import '../../features/mission/presentation/mission_play_screen.dart';
import '../../features/history/presentation/history_screen.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/talk',
      builder: (context, state) => const TalkScreen(),
    ),
    GoRoute(
      path: '/mission',
      builder: (context, state) => const MissionCategoryScreen(),
    ),
    GoRoute(
      path: '/mission/play',
      builder: (context, state) {
        final category = state.uri.queryParameters['category'] ?? '';
        return MissionPlayScreen(category: category);
      },
    ),
    GoRoute(
      path: '/history',
      builder: (context, state) => const HistoryScreen(),
    ),
  ],
);

