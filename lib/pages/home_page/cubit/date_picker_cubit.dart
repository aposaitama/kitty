import 'package:bloc/bloc.dart';

class MonthCubit extends Cubit<String?> {
  MonthCubit() : super(null);

  void selectMonth(String month) {
    emit(month);
  }
}
