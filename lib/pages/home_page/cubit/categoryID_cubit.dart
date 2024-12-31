import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitty/database/expenses_repository.dart';
import 'package:kitty/models/categories/categories.dart';

class CategoryIDCubit extends Cubit<Map<int, Categories?>> {
  final ExpensesRepository expensesRepository;

  CategoryIDCubit(this.expensesRepository) : super({});

  Future<void> loadCategory(int iconID) async {
    try {
      emit({...state, iconID: null});

      final category = await expensesRepository.getCategoryInfo(iconID);

      emit({...state, iconID: category});
    } catch (e) {
      emit({...state});
    }
  }
}
