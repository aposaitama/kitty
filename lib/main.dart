import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitty/pages/add_new_categories_page/cubit/add_new_category_cubit.dart';
import 'package:kitty/pages/home_page/cubit/date_picker_cubit.dart';
import 'package:kitty/route/app_navigation.dart';
import 'package:kitty/database/expenses_repository.dart';
import 'package:kitty/pages/add_new_page/cubit/expense_cubit.dart';
import 'package:kitty/route/cubit/navigation_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('uk')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => NavigationCubit(),
          ),
          BlocProvider(
            create: (context) => ExpenseCubit(ExpensesRepository()),
          ),
          BlocProvider(
            create: (context) => AddNewCategoryCubit(ExpensesRepository()),
          ),
          BlocProvider(
            create: (context) => MonthCubit(),
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
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: AppNavigation.router,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
