import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kitty/pages/add_new_categories_page/cubit/add_new_category_cubit.dart';
import 'package:kitty/pages/home_page/widget/type_list_tile_item.dart';
import 'package:kitty/route/app_navigation.dart';
import 'package:kitty/cubit/add_expenses/expense_cubit.dart';
import 'package:kitty/cubit/add_expenses/expense_cubit_state.dart';
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

    context.read<ExpenseCubit>().loadExpenses();
    context.read<AddNewCategoryCubit>().loadCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 32.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset('assets/icons/Logo.svg'),
                    Row(
                      children: [
                        SvgPicture.asset(
                            'assets/icons/search_black_24dp 1.svg'),
                        const SizedBox(
                          width: 16.0,
                        ),
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(30)),
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 28.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Transform.rotate(
                          angle: 3.1415,
                          child: SvgPicture.asset('assets/icons/right.svg')),
                      Container(
                        width: 124,
                        height: 32.0,
                        decoration: BoxDecoration(
                            color: AppColors.circleGreyColor,
                            borderRadius: BorderRadius.circular(30)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset('assets/icons/calendar_icon.svg'),
                            const SizedBox(
                              width: 8.0,
                            ),
                            const Text(
                              'May, 2021',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Inter',
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                      SvgPicture.asset('assets/icons/right.svg')
                    ],
                  ),
                ),

                const SizedBox(height: 28.0),

                Container(
                  height: 95.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border:
                        Border.all(width: 1.0, color: AppColors.borderColor),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    child: BlocBuilder<ExpenseCubit, ExpenseState>(
                      builder: (context, state) {
                        if (state is ExpenseLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (state is ExpenseLoaded) {
                          final totalExpenses = context
                              .read<ExpenseCubit>()
                              .calculateTotalExpenses(state.expenses);
                          final totalIncome = context
                              .read<ExpenseCubit>()
                              .calculateTotalIncome(state.expenses);
                          final balance = context
                              .read<ExpenseCubit>()
                              .calculateBalance(state.expenses);
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset('assets/icons/expense.svg'),
                                  const SizedBox(
                                    height: 6.0,
                                  ),
                                  Text(
                                    totalExpenses.toString(),
                                    style: const TextStyle(
                                        color: Colors.red,
                                        fontFamily: 'Inter',
                                        fontSize: 14.0,
                                        height: 1.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const Text(
                                    'Expenses',
                                    style: TextStyle(
                                        color: AppColors.header,
                                        fontFamily: 'Inter',
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset('assets/icons/balance.svg'),
                                  const SizedBox(
                                    height: 6.0,
                                  ),
                                  Text(
                                    balance.toString(),
                                    style: const TextStyle(
                                        color: AppColors.greenGreyColor,
                                        fontFamily: 'Inter',
                                        fontSize: 14.0,
                                        height: 1.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const Text(
                                    'Balance',
                                    style: TextStyle(
                                        color: AppColors.header,
                                        fontFamily: 'Inter',
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset('assets/icons/income.svg'),
                                  const SizedBox(
                                    height: 6.0,
                                  ),
                                  Text(
                                    totalIncome.toString(),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Inter',
                                        fontSize: 14.0,
                                        height: 1.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const Text(
                                    'Income',
                                    style: TextStyle(
                                        color: AppColors.header,
                                        fontFamily: 'Inter',
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              )
                            ],
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                ),

                // BlocBuilder to display the expenses
                Expanded(
                  child: BlocBuilder<ExpenseCubit, ExpenseState>(
                    builder: (context, state) {
                      if (state is ExpenseLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is ExpenseLoaded) {
                        // Групуємо витрати перед відображенням
                        final groupedExpenses = context
                            .read<ExpenseCubit>()
                            .groupExpensesByDate(state.expenses);

                        if (groupedExpenses.isEmpty) {
                          return const Center(
                            child: Text(
                              'No expenses yet.',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          );
                        }

                        return ListView.builder(
                          itemCount: groupedExpenses.keys.length,
                          itemBuilder: (context, index) {
                            final groupKey =
                                groupedExpenses.keys.elementAt(index);
                            final expenses = groupedExpenses[groupKey]!;

                            return Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        width: 1.0,
                                        color: AppColors.borderColor),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                groupKey.toUpperCase(),
                                                style: const TextStyle(
                                                  fontFamily: 'Inter',
                                                  fontSize: 10.0,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black,
                                                  letterSpacing: 1.5,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 7.0),
                                                child: Text(
                                                  expenses
                                                      .fold<double>(
                                                        0,
                                                        (sum, item) => item
                                                                    .type ==
                                                                'Expense'
                                                            ? sum -
                                                                double.parse(
                                                                    item.amount)
                                                            : sum +
                                                                double.parse(
                                                                    item.amount),
                                                      )
                                                      .toStringAsFixed(0),
                                                  style: const TextStyle(
                                                    fontFamily: 'Inter',
                                                    fontSize: 10.0,
                                                    letterSpacing: 1.5,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 6.0,
                                          ),
                                          ...expenses.map((expense) {
                                            return TypeListTileItem(
                                              categoryIcon:
                                                  expense.categoryIcon,
                                              type: expense.type,
                                              description: expense.description!,
                                              amount: expense.amount,
                                              name: expense.category,
                                            );
                                          }).toList(),
                                        ]),
                                  ),
                                ),
                                const SizedBox(
                                  height: 16.0,
                                ),
                              ],
                            );
                          },
                        );
                      } else if (state is ExpenseError) {
                        return Center(
                          child: Text(
                            'Error: ${state.message}',
                            style: const TextStyle(color: Colors.red),
                          ),
                        );
                      }

                      return const Center(child: Text('No expenses'));
                    },
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () => context.go('/add_new'),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 32.0),
                child: Container(
                  width: 130,
                  height: 48,
                  decoration: BoxDecoration(
                      color: AppColors.blueStackButton,
                      borderRadius: BorderRadius.circular(30)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/icons/add-plus-circle.svg'),
                      const SizedBox(
                        width: 6.0,
                      ),
                      const Text(
                        'Add new',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Inter',
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500),
                      )
                    ],
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
