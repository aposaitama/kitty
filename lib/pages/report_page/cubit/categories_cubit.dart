import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitty/database/expenses_repository.dart';
import 'package:kitty/models/expense/expense.dart';
import 'package:kitty/pages/report_page/cubit/statistics_date_cubit.dart'; // Важливо оновити шлях до вашого нового cubit

class CategoriesCubit extends Cubit<Map<String, Map<String, dynamic>>> {
  final ExpensesRepository expensesRepository;
  final StatisticsCubit
      statisticsCubit; // Заміна StatisticsCubitState на StatisticsCubit

  CategoriesCubit(this.expensesRepository, this.statisticsCubit) : super({});

  Future<void> groupTransactionsByCategory() async {
    try {
      // Отримати стан з StatisticsCubit
      final month = statisticsCubit.state['month'];
      final year = statisticsCubit.state['year'];

      // Отримати витрати для конкретного місяця та року
      final expenses =
          await expensesRepository.getExpensesByMonthAndYear(month, year);

      final groupedExpenses = <String, Map<String, dynamic>>{};
      double totalAmount = 0.0;

      for (Expense expense in expenses) {
        if (expense.category.isNotEmpty) {
          final category = expense.category;
          groupedExpenses[category] ??= {
            'Total': 0.0,
            'count': 0,
            'iconPath': '',
            'percentage': 0.0,
            'backgroundColor': 0,
          };

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

      // Розрахунок відсотка для кожної категорії
      for (String category in groupedExpenses.keys) {
        double total = groupedExpenses[category]!['Total'];
        double percentage =
            totalAmount != 0 ? (total / totalAmount) * 100 : 0.0;
        groupedExpenses[category]!['percentage'] = percentage;
      }

      // Емісія результатів
      emit(groupedExpenses);
    } catch (e) {
      emit({});
    }
  }
}
