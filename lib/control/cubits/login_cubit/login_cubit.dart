import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hii/control/cubits/login_cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    try {
      // Simulate a network request for login
      await Future.delayed(Duration(seconds: 2)); // Replace with actual login logic

      // Replace with your authentication service call
      // For example: await AuthService().login(email, password);

      emit(LoginSuccess());
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }
}