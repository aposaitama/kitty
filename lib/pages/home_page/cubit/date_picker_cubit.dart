import 'package:bloc/bloc.dart';

class MonthCubit extends Cubit<String?> {
  int currentYear = DateTime.now().year;
  MonthCubit() : super(null);

  void selectMonth(String month) {
    emit(month);
  }

  void changeYear(String year) {
    emit(year);
  }

  void decrementYear() {
    currentYear--;
    print(currentYear);
    emit(state);
  }
}
