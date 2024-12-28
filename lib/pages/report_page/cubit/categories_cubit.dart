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

      emit(groupedExpenses);
    } catch (e) {
      emit({});
    }
  }

  Future<Map<String, Map<String, dynamic>>> groupExpensesByMonth() async {
    try {
      // Отримуємо всі витрати
      final expenses = await expensesRepository.getAllExpenses();

      // Мапа для групування витрат по місяцях
      final Map<String, Map<String, dynamic>> allExpensesByMonth = {};

      for (Expense expense in expenses) {
        final yearMonth =
            '${expense.date.year}-${expense.date.month}'; // Місяць і рік у форматі YYYY-MM

        // Якщо цього місяця ще немає в мапі, додаємо
        if (!allExpensesByMonth.containsKey(yearMonth)) {
          allExpensesByMonth[yearMonth] = {};
        }

        // Якщо категорія вже є, додаємо суму
        final groupedExpenses = allExpensesByMonth[yearMonth]!;

        if (expense.category.isNotEmpty) {
          final category = expense.category;

          // Якщо категорія ще не додана для цього місяця
          if (!groupedExpenses.containsKey(category)) {
            groupedExpenses[category] = {
              'Total': 0.0,
              'count': 0,
            };
          }

          // Віднімаємо або додаємо суму залежно від типу витрат
          if (expense.type == 'Income') {
            groupedExpenses[category]!['Total'] += int.parse(expense.amount);
          } else {
            groupedExpenses[category]!['Total'] -=
                int.parse(expense.amount).abs();
          }

          // Загальна сума по категорії, кількість витрат, іконка категорії
          groupedExpenses[category]!['count'] += 1;
        }
      }

      print(allExpensesByMonth);
      return allExpensesByMonth;
    } catch (e) {
      print("Error grouping expenses: $e");
      return {};
    }
  }

  // Спостереження за змінами місяця та року
  void listenToMonthChanges(BuildContext context) {
    final dateCubit = context.read<StatisticsCubit>();

    dateCubit.stream.listen((state) {
      final month = state['month']!;
      final year = state['year']!;
      groupTransactionsByCategory(year, month);
    });
  }

  // Викликати цей метод при ініціалізації
  void startListeningToMonthChanges(BuildContext context) {
    listenToMonthChanges(context);
  }
}
