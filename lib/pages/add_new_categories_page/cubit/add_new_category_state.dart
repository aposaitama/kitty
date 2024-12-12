import 'package:flutter/foundation.dart';
import 'package:kitty/models/categories.dart';

abstract class AddNewCategoryState {}

class AddNewCategoryInitial extends AddNewCategoryState {}

class CategoryAddedSuccess extends AddNewCategoryState {}

class CategoryLoaded extends AddNewCategoryState {
  final List<Categories> category;

  CategoryLoaded(this.category);
}

class CategoryError extends AddNewCategoryState {
  final String message;
  CategoryError(this.message);
}
