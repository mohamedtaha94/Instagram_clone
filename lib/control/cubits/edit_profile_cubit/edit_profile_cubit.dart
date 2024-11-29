import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hii/control/cubits/edit_profile_cubit/edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileInitial());

  Future<void> updateProfile({
    required String name,
    required String username,
    required String website,
    required String bio,
    required String email,
    required String phone,
    required String gender,
  }) async {
    emit(EditProfileLoading());
    try {
      // Simulate a network request
      await Future.delayed(const Duration(seconds: 2));

      // Here you would call your API or database to update the profile
      // For example: await UserRepository.updateProfile(...);

      emit(EditProfileSuccess());
    } catch (e) {
      emit(EditProfileError(e.toString()));
    }
  }
}