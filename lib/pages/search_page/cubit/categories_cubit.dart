import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitty/database/categories_repository.dart';
import 'package:kitty/models/categories/categories.dart';

class SearchCategoriesCubit extends Cubit<List<Categories>> {
  final CategoriesRepository categoriesRepository;

  SearchCategoriesCubit(this.categoriesRepository) : super([]);

  Future<void> fetchCategories() async {
    final categories = await categoriesRepository.getAllCategories();
    emit(categories);
  }
}
