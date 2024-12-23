import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';

class StatisticsCubit extends Cubit<Map<String, dynamic>> {
  int currentYear = DateTime.now().year;
  int currentMonth = DateTime.now().month;
  StatisticsCubit()
      : super({'month': DateTime.now().month, 'year': DateTime.now().year});

  //selecting month
  void selectMonth(int month) {
    currentMonth = month;
    emit({
      'month': currentMonth,
      'year': currentYear,
    });
  }

  //decrementing on left arrow btn
  void decrementYear() {
    currentYear--;
    emit({
      'month': currentMonth,
      'year': currentYear,
    });
  }

  //incrementing on rigth arrow btn
  void incrementYear() {
    currentYear++;
    emit({
      'month': currentMonth,
      'year': currentYear,
    });
  }

  String getMonthName() {
    final DateTime date = DateTime(currentYear, currentMonth + 1);
    Intl.defaultLocale = 'en_US';
    final formatter = DateFormat('MMMM');
    return formatter.format(date);
  }
}
