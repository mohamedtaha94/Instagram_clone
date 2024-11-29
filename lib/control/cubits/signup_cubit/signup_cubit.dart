/*import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hii/control/cubits/signup_cubit/signup_state_dart';
import 'package:hii/control/firebase_Services/firebase_auth.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  Future<void> signup({
    required String email,
    required String password,
    required String passwordConfirm,
    required String username,
    required String bio,
    required File profile,
  }) async {
    emit(SignupLoading());
    try {
      await Authentication().Signup(
        email: email,
        password: password,
        passwordConfirm: passwordConfirm,
        username: username,
        bio: bio,
        profile: profile,
      );
      emit(SignupSuccess());
    } catch (e) {
      emit(SignupError(e.toString())); // Adjust to your error handling
    }
  }
}*/