import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hii/control/cubits/post_screen_cubit/post_screen_state.dart';

class PostScreenCubit extends Cubit<PostScreenState> {
  PostScreenCubit() : super(PostScreenInitial());

  void loadPost(dynamic snapshot) {
    emit(PostScreenLoading());
    try {
      // Simulate a delay for fetching post data
      Future.delayed(Duration(seconds: 1), () {
        // Here we assume snapshot is directly usable
        // Normally, you might fetch or transform data
        emit(PostScreenLoaded(snapshot));
      });
    } catch (e) {
      emit(PostScreenError(e.toString()));
    }
  }
}