import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitty/database/categories_repository.dart';
import 'package:kitty/models/categories/categories.dart';
import 'package:kitty/pages/add_new_categories_page/cubit/add_new_category_state.dart';

class AddNewCategoryCubit extends Cubit<AddNewCategoryState> {
  final CategoriesRepository categoriesRepository;
  AddNewCategoryCubit(this.categoriesRepository)
      : super(AddNewCategoryInitial());

  Future<void> loadCategory() async {
    try {
      final categories = await categoriesRepository.getAllCategories();

      final categoriesIcon = await categoriesRepository.getAllCategoriesIcons();

      emit(CategoryLoaded(categories, categoriesIcon));
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }

  Future<void> addCategory(
      String name, String iconPath, int backgroundColor) async {
    try {
      final nextOrderIndex = await categoriesRepository.getNextOrderIndex();

      final newCategory = Categories(
        background_color: backgroundColor,
        name: name,
        icon: iconPath,
        order_index: nextOrderIndex,
      );
      await categoriesRepository.addCategory(newCategory);
      loadCategory();
      emit(CategoryAddedSuccess());
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }

  Future<void> updateCategoryOrder(List<Categories> updatedCategories) async {
    try {
      await categoriesRepository.updateOrder(updatedCategories);
      loadCategory();
      emit(CategoryAddedSuccess());
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }
}
