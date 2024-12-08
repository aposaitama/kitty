import 'package:go_router/go_router.dart';
import 'package:kitty/feautures/dashboard/presentation/pages/home_page/home_page_screen.dart';
import 'package:kitty/feautures/dashboard/presentation/pages/report_page/report_page_screen.dart';
import 'package:kitty/feautures/dashboard/presentation/pages/root_screen/root_screen.dart';
import 'package:kitty/feautures/dashboard/presentation/pages/settings_page/settings_page_screen.dart';

class AppNavigation {
  AppNavigation._();

  static String initR = '/home';

  // GoRouter Configuration
  static final GoRouter router =
      GoRouter(initialLocation: initR, routes: <RouteBase>[
    // Define the root StatefulShellRoute

    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          RootScreen(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home', // Home tab
              builder: (context, state) => const HomePageScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings', // Cart tab
              builder: (context, state) => const SettingsPageScreen(),
            ),
          ],
        ),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/report', // Checkout tab
            builder: (context, state) => const ReportPageScreen(),
          ),
        ]),
      ],
    ),
  ]);
}
