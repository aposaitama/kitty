import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset('assets/icons/expense.svg'),
                            const SizedBox(
                              height: 6.0,
                            ),
                            const Text(
                              '-12,000',
                              style: TextStyle(
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
                            const Text(
                              '48,000',
                              style: TextStyle(
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
                            const Text(
                              '70,000',
                              style: TextStyle(
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
                    ),
                  ),
                ),

                // BlocBuilder to display the expenses
                Expanded(
                  child: BlocBuilder<ExpenseCubit, ExpenseState>(
                    builder: (context, state) {
                      print('Current state: $state');
                      if (state is ExpenseLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is ExpenseLoaded) {
                        final expenses = state.expenses;
                        if (expenses.isEmpty) {
                          return const Center(
                            child: Text(
                              'No expenses yet.',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          );
                        }

                        return ListView.builder(
                          itemCount: expenses.length,
                          itemBuilder: (context, index) {
                            final expense = expenses[index];
                            return ListTile(
                              leading: Text(expense.type),
                              subtitle: Text(expense.date.toString()),
                              trailing: Text('${expense.amount} \$'),
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
                      return const Center(child: Text('No expences'));
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
