import 'package:kitty/models/categories/categories.dart';
import 'package:kitty/models/categories_icon/categoriesicon.dart';

abstract class AddNewCategoryState {}

class AddNewCategoryInitial extends AddNewCategoryState {}

class CategoryAddedSuccess extends AddNewCategoryState {}

class CategoryLoading extends AddNewCategoryState {}

class CategoryLoaded extends AddNewCategoryState {
  final List<Categories> category;
  final List<CategoriesIcon> categoryIcons;

  CategoryLoaded(this.category, this.categoryIcons);
}

class CategoryError extends AddNewCategoryState {
  final String message;
  CategoryError(this.message);
}
