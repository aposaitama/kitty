import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitty/database/expenses_repository.dart';
import 'package:kitty/models/expense/expense.dart';

class TypeByCategoryCubit extends Cubit<Map<String, List<Expense>>> {
  final ExpensesRepository expensesRepository;

  TypeByCategoryCubit(this.expensesRepository) : super({});

  Future<void> fetchItemByCategory(List<String> categoryName) async {
    final items = await expensesRepository.getElemByCategory(categoryName);
    final sortedItems = await expensesRepository.groupExpensesByDate(items);
    emit(sortedItems);
  }
}
