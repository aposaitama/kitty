import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kitty/pages/add_new_page/cubit/expense_cubit_state.dart';
import 'package:kitty/pages/auth_pages/cubit/auth_cubit.dart';
import 'package:kitty/pages/home_page/widget/calculate_top_bar.dart';
import 'package:kitty/pages/home_page/widget/date_picker_overlay.dart';
import 'package:kitty/pages/home_page/widget/grouped_expenses_list.dart';
import 'package:kitty/route/cubit/navigation_cubit.dart';
import 'package:kitty/pages/add_new_categories_page/cubit/add_new_category_cubit.dart';
import 'package:kitty/pages/add_new_page/cubit/expense_cubit.dart';
import 'package:kitty/styles/colors.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    int currentMonth = now.month;
    int currentYear = now.year;
    context
        .read<ExpenseCubit>()
        .loadExpensesByMonthAndYear(currentMonth, currentYear);
    context.read<AddNewCategoryCubit>().loadCategory();
    context.read<ExpenseCubit>().startListeningToMonthChanges(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: SvgPicture.asset(
            'assets/icons/Logo.svg',
          ),
        ),
        title: const Text(
          'Kitty',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 20.0,
            letterSpacing: 0.18,
            fontWeight: FontWeight.w900,
            color: AppColors.header,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => context.go(
                    '/search',
                  ),
                  child: SvgPicture.asset(
                    'assets/icons/search_black_24dp 1.svg',
                  ),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                BlocBuilder<NavigationCubit, String>(
                  builder: (context, state) {
                    return GestureDetector(
                      onTap: () {
                        context
                            .read<NavigationCubit>()
                            .updateRoute('/settings');
                        GoRouter.of(context).go('/settings');
                      },
                      child: BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                          final user =
                              context.read<AuthCubit>().getCurrentUser();
                          final iconPath = user?.icon;

                          final fileExists =
                              iconPath != null && File(iconPath).existsSync();

                          return CircleAvatar(
                            radius: 24,
                            backgroundImage: fileExists
                                ? FileImage(
                                    File(iconPath),
                                  )
                                : null,
                            child: !fileExists
                                ? const Icon(
                                    Icons.account_circle,
                                    size: 24,
                                  )
                                : null,
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 28.0,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  child: DatePickerOverlay(),
                ),
                const SizedBox(
                  height: 28.0,
                ),
                Container(
                  height: 95.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      width: 1.0,
                      color: AppColors.borderColor,
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 28.0,
                    ),
                    child: CalculateTopBar(),
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                BlocListener<ExpenseCubit, ExpenseState>(
                  listener: (context, state) {
                    if (state is ExpenseLoaded) {
                      setState(() {});
                    }
                  },
                  child: const GroupedExpensesList(),
                )
              ],
            ),
            GestureDetector(
              onTap: () => context.go('/add_new'),
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 32.0,
                ),
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.blueStackButton,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/add-plus-circle.svg',
                        ),
                        const SizedBox(
                          width: 6.0,
                        ),
                        Text(
                          "blue_gesture_button".tr(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Inter',
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
