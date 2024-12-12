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
                const SizedBox(height: 16.0),

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
                              title: Text(expense.title),
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
