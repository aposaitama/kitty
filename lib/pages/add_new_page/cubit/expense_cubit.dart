import 'package:flutter/material.dart';
import 'package:kitty/database/expenses_repository.dart';
import 'package:kitty/models/expense/expense.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kitty/pages/add_new_page/cubit/expense_cubit_state.dart';
import 'package:kitty/pages/home_page/cubit/date_picker_cubit.dart';

class ExpenseCubit extends Cubit<ExpenseState> {
  final ExpensesRepository expenseRepository;

  ExpenseCubit(this.expenseRepository) : super(ExpenseInitial());

  Future<void> loadExpenses() async {
    try {
      emit(ExpenseLoading());
      final expenses = await expenseRepository.getAllExpenses();

      //sorting
      final groupedExpenses = expenseRepository.groupExpensesByDate(expenses);

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

  Future<void> addExpense(Expense expense) async {
    try {
      emit(ExpenseLoading());
      await expenseRepository.addExpense(expense);
      await Future.delayed(const Duration(milliseconds: 500));
      final month = DateTime.now().month;
      final year = DateTime.now().year;
      final updatedExpenses =
          await expenseRepository.getExpensesByMonthAndYear(month, year);
      emit(ExpenseLoaded(updatedExpenses));
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

  Future<void> loadExpensesByMonthAndYear(int month, int year) async {
    try {
      emit(ExpenseLoading());
      final expenses =
          await expenseRepository.getExpensesByMonthAndYear(month, year);
      emit(ExpenseLoaded(expenses));
    } catch (e) {
      emit(ExpenseError(e.toString()));
    }
  }

  // Спостереження за змінами місяця та року
  void listenToMonthChanges(BuildContext context) {
    final monthCubit = context.read<MonthCubit>();

    monthCubit.stream.listen((state) {
      final month = state['month']!;
      final year = state['year']!;
      loadExpensesByMonthAndYear(month, year);
    });
  }

  // Викликати цей метод при ініціалізації
  void startListeningToMonthChanges(BuildContext context) {
    listenToMonthChanges(context);
  }
}
