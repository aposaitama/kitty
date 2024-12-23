import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitty/pages/add_new_page/cubit/expense_cubit.dart';
import 'package:kitty/pages/add_new_page/cubit/expense_cubit_state.dart';
import 'package:kitty/pages/home_page/widget/type_list_tile_item.dart';
import 'package:kitty/styles/colors.dart';

class GroupedExpensesList extends StatelessWidget {
  const GroupedExpensesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<ExpenseCubit, ExpenseState>(
        builder: (context, state) {
          if (state is ExpenseLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ExpenseLoaded) {
            final groupedExpenses = context
                .read<ExpenseCubit>()
                .expenseRepository
                .groupExpensesByDate(state.expenses);

            if (groupedExpenses.isEmpty) {
              return const Center(
                child: Text(
                  'No expenses yet.',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              );
            }

            return ListView.builder(
              itemCount: groupedExpenses.keys.length,
              itemBuilder: (context, index) {
                final groupKey = groupedExpenses.keys.elementAt(index);
                final expenses = groupedExpenses[groupKey]!;

                return Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          8,
                        ),
                        border: Border.all(
                          width: 1.0,
                          color: AppColors.borderColor,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(
                          16.0,
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                      right: 7.0,
                                    ),
                                    child: Text(
                                      expenses
                                          .fold<double>(
                                            0,
                                            (sum, item) => item.type ==
                                                    'Expense'
                                                ? sum -
                                                    double.parse(item.amount)
                                                : sum +
                                                    double.parse(item.amount),
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
                                  backgrondColor: expense.backgroundColor,
                                  categoryIcon: expense.categoryIcon,
                                  type: expense.type,
                                  description: expense.description!,
                                  amount: expense.amount,
                                  name: expense.category,
                                );
                              }),
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
                style: const TextStyle(
                  color: Colors.red,
                ),
              ),
            );
          }

          return const Center(
            child: Text(
              'No expenses',
            ),
          );
        },
      ),
    );
  }
}
