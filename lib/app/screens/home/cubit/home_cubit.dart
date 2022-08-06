import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_postman/app/screens/home/home.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState());

  void selectScreen(int index) {
    emit(HomeState(selectedScreenIndex: index));
  }
}
