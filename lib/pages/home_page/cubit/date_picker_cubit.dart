import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class MonthCubit extends Cubit<Map<String, dynamic>> {
  int currentYear = DateTime.now().year;
  int currentMonth = DateTime.now().month;

  MonthCubit()
      : super({'month': DateTime.now().month, 'year': DateTime.now().year});

  //selecting month
  void selectMonth(int month) {
    currentMonth = month;
    emit(
      {
        'month': currentMonth,
        'year': currentYear,
      },
    );
  }

  //decrementing on left arrow btn
  void decrementYear() {
    currentYear--;
    emit(
      {
        'month': currentMonth,
        'year': currentYear,
      },
    );
  }

  //incrementing on rigth arrow btn
  void incrementYear() {
    currentYear++;
    emit(
      {
        'month': currentMonth,
        'year': currentYear,
      },
    );
  }

  String getMonthName() {
    final DateTime date = DateTime(currentYear, currentMonth);
    Intl.defaultLocale = 'en_US';
    final formatter = DateFormat('MMMM');
    return formatter.format(date);
  }
}
