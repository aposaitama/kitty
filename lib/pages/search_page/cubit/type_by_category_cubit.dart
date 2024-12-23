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

  Future<void> filterByCategoryAndName(
      List<String> categoryNames, String? searchQuery) async {
    final allExpenses = await expensesRepository.getAllExpenses();

    //if category is pressed, than filter data
    List<Expense> filteredExpenses = allExpenses;
    if (categoryNames.isNotEmpty) {
      filteredExpenses = filteredExpenses.where((expense) {
        return categoryNames.contains(expense.category);
      }).toList();
    }

    //filter by text
    if (searchQuery != null && searchQuery.isNotEmpty) {
      filteredExpenses = filteredExpenses.where((expense) {
        return (expense.description != null &&
            expense.description!
                .toLowerCase()
                .contains(searchQuery.toLowerCase()));
      }).toList();
    }

    //group by date
    final groupedExpenses =
        await expensesRepository.groupExpensesByDate(filteredExpenses);

    emit(groupedExpenses);
  }
}
