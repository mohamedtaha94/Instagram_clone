import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hii/control/cubits/add_screen_cubit/add_Screen_state.dart';

class AddScreenCubit extends Cubit<AddScreenState> {
  AddScreenCubit() : super(AddScreenInitial());

  void changePage(int index) {
    emit(AddScreenPageChanged(index));
  }
}