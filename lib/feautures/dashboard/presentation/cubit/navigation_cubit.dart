import 'package:bloc/bloc.dart';

class NavigationCubit extends Cubit<String> {
  NavigationCubit() : super('/home');

  void updateRoute(String newRoute) => emit(newRoute);
}
