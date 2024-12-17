import 'package:kitty/database/expenses_repository.dart';
import 'package:kitty/models/expense/expense.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kitty/pages/add_new_page/cubit/expense_cubit_state.dart';

class ExpenseCubit extends Cubit<ExpenseState> {
  final ExpensesRepository expenseRepository;

  ExpenseCubit(this.expenseRepository) : super(ExpenseInitial());

  Future<void> loadExpenses() async {
    try {
      emit(ExpenseLoading());
      final expenses = await expenseRepository.getAllExpenses();

      //sorting
      final groupedExpenses = groupExpensesByDate(expenses);

      //into list
      List<Expense> flatExpenses = [];
      groupedExpenses.forEach((key, value) {
        flatExpenses.addAll(value);
      });

      emit(ExpenseLoaded(flatExpenses));
    } catch (e) {
      emit(ExpenseError(e.toString()));
    }
  }

  Map<String, List<Expense>> groupExpensesByDate(List<Expense> expenses) {
    final now = DateTime.now();
    Map<String, List<Expense>> grouped = {};

    for (var expense in expenses) {
      final difference = now.difference(expense.date).inDays;

      String groupKey;

      if (difference == 0) {
        groupKey = "TODAY";
      } else if (difference == 1) {
        groupKey = "YESTERDAY";
      } else {
        groupKey = "$difference days ago";
      }

      if (grouped[groupKey] == null) {
        grouped[groupKey] = [];
      }

      grouped[groupKey]!.add(expense);
    }

    return grouped;
  }

  Future<void> addExpense(Expense expense) async {
    try {
      emit(ExpenseLoading());
      await expenseRepository.addExpense(expense);
      await Future.delayed(const Duration(milliseconds: 500));
      await loadExpenses();
    } catch (e) {
      emit(ExpenseError(e.toString()));
    }
  }

  //expenses
  double calculateTotalExpenses(List<Expense> expenses) {
    return expenses
        .where((expense) => expense.type == 'Expense')
        .fold(0.0, (sum, item) => sum + int.parse(item.amount));
  }

  //income
  double calculateTotalIncome(List<Expense> expenses) {
    return expenses
        .where((expense) => expense.type == 'Income')
        .fold(0.0, (sum, item) => sum + int.parse(item.amount));
  }

  //balance
  double calculateBalance(List<Expense> expenses) {
    final income = calculateTotalIncome(expenses);
    final totalExpenses = calculateTotalExpenses(expenses);
    return income - totalExpenses;
  }
}
