import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class StatisticsCubit extends Cubit<Map<String, dynamic>> {
  // Зберігає поточний місяць і рік
  late int currentYear;
  late int currentMonth;

  // Конструктор, який встановлює поточний місяць та рік
  StatisticsCubit({String? selectedMonth, int? year})
      : super({
          'month':
              selectedMonth ?? DateTime.now().month.toString().padLeft(2, '0'),
          'year': year ?? DateTime.now().year,
        }) {
    currentMonth = int.parse(state['month']);
    currentYear = state['year'];
  }

  // Вибір місяця
  void selectMonth(int month) {
    currentMonth = month;
    emit({
      'month': month.toString().padLeft(2, '0'),
      'year': currentYear,
    });
  }

  // Зменшення року
  void decrementYear() {
    currentYear--;
    emit({
      'month': currentMonth.toString().padLeft(2, '0'),
      'year': currentYear,
    });
  }

  // Збільшення року
  void incrementYear() {
    currentYear++;
    emit({
      'month': currentMonth.toString().padLeft(2, '0'),
      'year': currentYear,
    });
  }

  // Отримання назви місяця
  String getMonthName() {
    final DateTime date = DateTime(currentYear, currentMonth);
    Intl.defaultLocale =
        'en_US'; // Ви можете змінити на 'uk_UA' або інший локаль для української мови
    final formatter = DateFormat('MMMM');
    return formatter.format(date);
  }

  // Оновлення року
  void updateYear(int newYear) {
    emit({
      'month': state['month'],
      'year': newYear,
    });
  }
}
