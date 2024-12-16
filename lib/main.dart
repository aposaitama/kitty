import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitty/pages/add_new_categories_page/cubit/add_new_category_cubit.dart';
import 'package:kitty/pages/settings_page/choose_language_page/provider/localization_cubit.dart';
import 'package:kitty/route/app_navigation.dart';
import 'package:kitty/database/expenses_repository.dart';

import 'package:kitty/cubit/add_expenses/expense_cubit.dart';
import 'package:kitty/cubit/navigation_cubit.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('uk')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LocaleProvider()),
          BlocProvider(
            create: (context) => NavigationCubit(),
          ),

          // RepositoryProvider<ExpenseRepository>(
          //   create: (_) => ExpensesRepository(),
          // ),
          BlocProvider(
            create: (context) => ExpenseCubit(ExpensesRepository()),
          ),
          BlocProvider(
            create: (context) => AddNewCategoryCubit(ExpensesRepository()),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleProvider>(
      builder: (context, localeProvider, child) {
        return MaterialApp.router(
          title: 'Flutter Demo',
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          routerConfig: AppNavigation.router,
          locale: localeProvider.locale, // Оновлюємо локаль з LocaleProvider
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          // home: const MyHomePage(title: 'Flutter Demo Home Page'),
        );
      },
    );
  }
}
