import 'package:kitty/database/expenses_repository.dart';
import 'package:kitty/models/expense.dart';
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
      loadExpenses();
      emit(ExpenseAddedSuccess());
    } catch (e) {
      emit(ExpenseError(e.toString()));
    }
  }
}
