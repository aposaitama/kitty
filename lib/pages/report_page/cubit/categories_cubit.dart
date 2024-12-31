import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitty/database/expenses_repository.dart';
import 'package:kitty/models/expense/expense.dart';
import 'package:kitty/pages/report_page/cubit/statistics_date_cubit.dart';

class CategoriesCubit extends Cubit<Map<String, Map<String, dynamic>>> {
  final ExpensesRepository expensesRepository;
  CategoriesCubit(this.expensesRepository) : super({});
  Future<void> groupTransactionsByCategory(
      int currentYear, int currentMonth) async {
    try {
      //get all cat
      final expenses = await expensesRepository.getAllExpenses();

      //grouped items
      final groupedExpenses = <String, Map<String, dynamic>>{};
      double totalAmount = 0.0;
      for (Expense expense in expenses) {
        if (expense.category.isNotEmpty) {
          if (expense.date.year == currentYear &&
              expense.date.month == currentMonth) {
            final category = expense.category;

            //cteated map?
            groupedExpenses[category] ??= {
              'Total': 0.0,
              'count': 0,
              'iconPath': '',
              'percentage': 0.0,
              'backgroundColor': 0,
              'iconId': 0
            };

            //insert into map
            if (expense.type == 'Income') {
              groupedExpenses[category]!['Total'] += int.parse(expense.amount);
              totalAmount += int.parse(expense.amount);
            } else {
              groupedExpenses[category]!['Total'] -=
                  int.parse(expense.amount).abs();
              totalAmount -= int.parse(expense.amount);
            }
            groupedExpenses[category]!['iconPath'] = expense.categoryIcon;
            groupedExpenses[category]!['iconId'] = expense.categoryId;
            groupedExpenses[category]!['backgroundColor'] =
                expense.backgroundColor;
            groupedExpenses[category]!['count'] += 1;
          }
        }
      }

      for (String category in groupedExpenses.keys) {
        double total = groupedExpenses[category]!['Total'];
        double percentage =
            totalAmount != 0 ? (total / totalAmount) * 100 : 0.0;
        groupedExpenses[category]!['percentage'] = percentage;
      }

      //sort by Total
      final sortedGroupedExpenses = LinkedHashMap.fromEntries(
        groupedExpenses.entries.toList()
          ..sort(
            (a, b) => (a.value['Total'] as double).compareTo(
              b.value['Total'] as double,
            ),
          ),
      );
      // print(sortedGroupedExpenses);
      emit(sortedGroupedExpenses);
    } catch (e) {
      emit({});
    }
  }

  Future<Map<String, Map<String, dynamic>>> groupExpensesByMonth() async {
    try {
      final expenses = await expensesRepository.getAllExpenses();

      final Map<String, Map<String, dynamic>> allExpensesByMonth = {};

      for (Expense expense in expenses) {
        final yearMonth = '${expense.date.year}-${expense.date.month}';

        if (!allExpensesByMonth.containsKey(yearMonth)) {
          allExpensesByMonth[yearMonth] = {};
        }

        final groupedExpenses = allExpensesByMonth[yearMonth]!;

        if (expense.category.isNotEmpty) {
          final category = expense.category;

          if (!groupedExpenses.containsKey(category)) {
            groupedExpenses[category] = {
              'Total': 0.0,
              'count': 0,
            };
          }

          if (expense.type == 'Income') {
            groupedExpenses[category]!['Total'] += int.parse(expense.amount);
          } else {
            groupedExpenses[category]!['Total'] -=
                int.parse(expense.amount).abs();
          }

          groupedExpenses[category]!['count'] += 1;
        }
      }

      final expensesKeysList = allExpensesByMonth.keys.toList().reversed;

      Map<String, Map<String, dynamic>> reversedAllExpensesByMonth = {
        for (var key in expensesKeysList) key: allExpensesByMonth[key]!
      };
      return reversedAllExpensesByMonth;
    } catch (e) {
      return {};
    }
  }

  void listenToMonthChanges(BuildContext context) {
    final dateCubit = context.read<StatisticsCubit>();

    dateCubit.stream.listen((state) {
      final month = state['month']!;
      final year = state['year']!;
      groupTransactionsByCategory(year, month);
    });
  }

  void startListeningToMonthChanges(BuildContext context) {
    listenToMonthChanges(context);
  }
}
