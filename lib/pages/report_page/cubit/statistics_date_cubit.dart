import 'package:bloc/bloc.dart';

class StatisticsCubit extends Cubit<String?> {
  int currentYear = DateTime.now().year;
  StatisticsCubit() : super(null);

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
