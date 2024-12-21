import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitty/database/expenses_repository.dart';
import 'package:kitty/models/expense/expense.dart';

class CategoriesCubit extends Cubit<Map<String, Map<String, dynamic>>> {
  final ExpensesRepository expensesRepository;
  CategoriesCubit(this.expensesRepository) : super({});
  Future<void> groupTransactionsByCategory() async {
    try {
      // Получаем все транзакции
      final expenses = await expensesRepository.getAllExpenses();

      // Группируем по категориям
      final groupedExpenses = <String, Map<String, dynamic>>{};
      double totalAmount = 0.0;
      for (Expense expense in expenses) {
        if (expense.category.isNotEmpty) {
          final category = expense.category;

          // Инициализируем категорию, если её ещё нет
          groupedExpenses[category] ??= {
            'Total': 0.0,
            'count': 0,
            'iconPath': '',
            'percentage': 0.0,
          };

          // Увеличиваем сумму и количество
          if (expense.type == 'Income') {
            groupedExpenses[category]!['Total'] += int.parse(expense.amount);
            totalAmount += int.parse(expense.amount);
          } else {
            groupedExpenses[category]!['Total'] -=
                int.parse(expense.amount).abs();
            totalAmount -= int.parse(expense.amount);
          }
          groupedExpenses[category]!['iconPath'] = expense.categoryIcon;
          groupedExpenses[category]!['count'] += 1;
        }
      }

      for (String category in groupedExpenses.keys) {
        double total = groupedExpenses[category]!['Total'];
        double percentage =
            totalAmount != 0 ? (total / totalAmount) * 100 : 0.0;
        groupedExpenses[category]!['percentage'] = percentage;
      }

      // Обновляем состояние
      emit(groupedExpenses);
    } catch (e) {
      emit({});
    }
  }
}