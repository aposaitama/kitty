import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitty/database/expenses_repository.dart';
import 'package:kitty/models/categories/categories.dart';

class CategoryIDCubit extends Cubit<Map<int, Categories?>> {
  final ExpensesRepository expensesRepository;

  CategoryIDCubit(this.expensesRepository) : super({});

  Future<void> loadCategory(int iconID) async {
    try {
      // Позначаємо цей iconID як "завантажується"
      emit({...state, iconID: null});

      final category = await expensesRepository.getCategoryInfo(iconID);

      // Оновлюємо стан для конкретного iconID
      emit({...state, iconID: category});
    } catch (e) {
      // Якщо сталася помилка, не оновлюємо категорію
      emit({...state});
    }
  }
}
