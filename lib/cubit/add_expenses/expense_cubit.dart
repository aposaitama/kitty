import 'package:kitty/database/expenses_repository.dart';
import 'package:kitty/models/expense/expense.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kitty/cubit/add_expenses/expense_cubit_state.dart';

class ExpenseCubit extends Cubit<ExpenseState> {
  final ExpensesRepository expenseRepository;

  ExpenseCubit(this.expenseRepository) : super(ExpenseInitial());

  Future<void> loadExpenses() async {
    try {
      emit(ExpenseLoading());
      final expenses = await expenseRepository.getAllExpenses();
      emit(ExpenseLoaded(expenses));
    } catch (e) {
      emit(ExpenseError(e.toString()));
    }
  }

  Future<void> addExpense(Expense expense) async {
    try {
      emit(ExpenseLoading());
      await expenseRepository.addExpense(expense);
      await Future.delayed(
          Duration(milliseconds: 500)); // Затримка перед оновленням
      await loadExpenses();
    } catch (e) {
      emit(ExpenseError(e.toString()));
    }
  }

  double calculateTotalExpenses(List<Expense> expenses) {
    return expenses
        .where((expense) => expense.type == 'Expense')
        .fold(0.0, (sum, item) => sum + int.parse(item.amount));
  }

  double calculateTotalIncome(List<Expense> expenses) {
    return expenses
        .where((expense) => expense.type == 'Income')
        .fold(0.0, (sum, item) => sum + int.parse(item.amount));
  }

  // Розрахунок балансу
  double calculateBalance(List<Expense> expenses) {
    final income = calculateTotalIncome(expenses);
    final totalExpenses = calculateTotalExpenses(expenses);
    return income - totalExpenses;
  }
}
