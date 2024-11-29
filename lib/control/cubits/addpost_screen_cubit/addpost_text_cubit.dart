import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hii/control/cubits/addpost_screen_cubit/addpsot_text_state.dart';
import 'dart:io';
import 'package:hii/control/firebase_Services/firestor.dart';
import 'package:hii/control/firebase_Services/storage.dart';

class AddPostCubit extends Cubit<AddPostState> {
  AddPostCubit() : super(AddPostInitial());

  Future<void> createPost(File file, String caption, String location) async {
    emit(AddPostLoading());
    try {
      String postUrl = await StorageMethod().uploadImageToStorage('post', file);
      await Firebase_Firestor().CreatePost(
        postImage: postUrl,
        caption: caption,
        location: location,
      );
      emit(AddPostSuccess());
    } catch (e) {
      emit(AddPostError(e.toString()));
    }
  }
}