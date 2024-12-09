import 'package:kitty/feautures/dashboard/domain/entity/expense.dart';

abstract class ExpenseRepository {
  Future<void> addExpense(Expense expense);
  Future<List<Expense>> getAllExpenses();
}
