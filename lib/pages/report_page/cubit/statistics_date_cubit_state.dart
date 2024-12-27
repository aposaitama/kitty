import 'package:flutter_bloc/flutter_bloc.dart';

class StatisticsCubitState extends Cubit<Map<String, dynamic>> {
  StatisticsCubitState({required String selectedMonth, required int year})
      : super({'month': selectedMonth, 'year': year});

  // Функція для оновлення місяця
  void updateMonth(String newMonth) {
    emit({'month': newMonth, 'year': state['year']});
  }

  // Функція для оновлення року
  void updateYear(int newYear) {
    emit({'month': state['month'], 'year': newYear});
  }

  // Функція для отримання назви місяця
  String getMonthName() {
    final month = state['month'];
    switch (month) {
      case '01':
        return 'January';
      case '02':
        return 'February';
      case '03':
        return 'March';
      case '04':
        return 'April';
      case '05':
        return 'May';
      case '06':
        return 'June';
      case '07':
        return 'July';
      case '08':
        return 'August';
      case '09':
        return 'September';
      case '10':
        return 'October';
      case '11':
        return 'November';
      case '12':
        return 'December';
      default:
        return 'Unknown';
    }
  }
}
