import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kitty/database/categories_repository.dart';
import 'package:kitty/database/hive/hive_repository.dart';
import 'package:kitty/database/hive/hive_service.dart';
import 'package:kitty/models/user/user.dart';
import 'package:kitty/pages/add_new_categories_page/cubit/add_new_category_cubit.dart';
import 'package:kitty/pages/auth_pages/cubit/auth_cubit.dart';
import 'package:kitty/pages/home_page/cubit/categoryID_cubit.dart';
import 'package:kitty/pages/home_page/cubit/date_picker_cubit.dart';
import 'package:kitty/pages/report_page/cubit/categories_cubit.dart';
import 'package:kitty/pages/report_page/cubit/statistics_date_cubit.dart';
import 'package:kitty/pages/search_page/cubit/search_categories_cubit.dart';
import 'package:kitty/pages/search_page/cubit/type_by_category_cubit.dart';
import 'package:kitty/route/app_navigation.dart';
import 'package:kitty/database/expenses_repository.dart';
import 'package:kitty/pages/add_new_page/cubit/expense_cubit.dart';
import 'package:kitty/route/cubit/navigation_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await HiveService.initialize();

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
            create: (context) => AuthCubit(AuthRepository())..checkAuthStatus(),
          ),
          BlocProvider(
            create: (context) => ExpenseCubit(ExpensesRepository()),
          ),
          BlocProvider(
            create: (context) => AddNewCategoryCubit(CategoriesRepository()),
          ),
          BlocProvider(
            create: (context) => MonthCubit(),
          ),
          BlocProvider(
            create: (context) => CategoryIDCubit(ExpensesRepository()),
          ),
          BlocProvider(
            create: (context) => TypeByCategoryCubit(ExpensesRepository()),
          ),
          BlocProvider(
            create: (context) => CategoriesCubit(ExpensesRepository()),
          ),
          BlocProvider(
            create: (context) => StatisticsCubit(),
          ),
          BlocProvider(
              create: (context) =>
                  SearchCategoriesCubit(CategoriesRepository())),
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
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          backgroundColor: Colors.white,
          toolbarHeight: 32.0,
        ),
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter().createRouter(context),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}
