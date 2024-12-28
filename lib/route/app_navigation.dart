import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kitty/pages/add_new_categories_page/add_new_categories.dart';
import 'package:kitty/pages/add_new_page/add_new_page.dart';
import 'package:kitty/pages/auth_pages/cubit/auth_cubit.dart';
import 'package:kitty/pages/auth_pages/password_page/password_page.dart';
import 'package:kitty/pages/home_page/home_page_screen.dart';
import 'package:kitty/pages/auth_pages/login_page/login_page.dart';
import 'package:kitty/pages/auth_pages/register_page/register_page.dart';
import 'package:kitty/pages/report_page/report_page_screen.dart';
import 'package:kitty/pages/root_screen/root_screen.dart';
import 'package:kitty/pages/search_page/search_page.dart';
import 'package:kitty/pages/settings_page/choose_language_page/choose_language_page.dart';
import 'package:kitty/pages/settings_page/manage_categories_page/manage_categories_page.dart';
import 'package:kitty/pages/settings_page/settings_page_screen.dart';

class AppRouter {
  GoRouter createRouter(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    return GoRouter(
      initialLocation: '/home',
      redirect: (context, state) {
        //getting state
        final authState = authCubit.state;

        // Якщо користувач вже аутентифікований і намагається перейти на сторінку входу або реєстрації
        if (authState == AuthState.authenticated &&
            (state.uri.toString() == '/login' ||
                state.uri.toString() == '/register')) {
          return '/home';
        }

        if (authState == AuthState.passwordRequired &&
            state.uri.toString() != '/password') {
          return '/password';
        }

        if (authState == AuthState.unauthenticated &&
            !['/login', '/register'].contains(state.uri.toString())) {
          return '/login';
        }

        return null;
      },
      routes: <RouteBase>[
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) =>
              RootScreen(navigationShell: navigationShell),
          branches: [
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/home',
                  builder: (context, state) => const HomePageScreen(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/settings',
                  builder: (context, state) => const SettingsPageScreen(),
                  routes: [
                    GoRoute(
                      path: 'choose_language',
                      builder: (context, state) => const ChooseLanguagePage(),
                    ),
                  ],
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/report',
                  builder: (context, state) => const ReportPageScreen(),
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          path: '/add_new',
          builder: (context, state) => const AddNewExpenseScreen(),
          routes: [
            GoRoute(
              path: 'add_new_categories',
              builder: (context, state) => const AddNewCategories(),
            ),
          ],
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: '/register',
          builder: (context, state) => const RegisterPage(),
        ),
        GoRoute(
          path: '/password',
          builder: (context, state) => PasswordInputPage(),
        ),
        GoRoute(
          path: '/search',
          builder: (context, state) => const SearchPage(),
        ),
        GoRoute(
          path: '/manage_categories',
          builder: (context, state) => const ManageCategoriesPage(),
          routes: [
            GoRoute(
              path: 'add_new_categories',
              builder: (context, state) => const AddNewCategories(),
            ),
          ],
        ),
      ],
    );
  }
}
