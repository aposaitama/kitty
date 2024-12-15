import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitty/database/expenses_repository.dart';
import 'package:kitty/models/categories/categories.dart';
import 'package:kitty/pages/add_new_categories_page/cubit/add_new_category_state.dart';

class AddNewCategoryCubit extends Cubit<AddNewCategoryState> {
  final ExpensesRepository expenseRepository;
  AddNewCategoryCubit(this.expenseRepository) : super(AddNewCategoryInitial());

  Future<void> loadCategory() async {
    try {
      final categories = await expenseRepository.getAllCategories();
      emit(CategoryLoaded(categories));
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }

  Future<void> addCategory(Categories category) async {
    try {
      await expenseRepository.addCategory(category);
      loadCategory();
      emit(CategoryAddedSuccess());
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }
}
