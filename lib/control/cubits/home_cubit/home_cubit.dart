import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hii/control/cubits/home_cubit/home_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  final FirebaseFirestore _firebaseFirestore;

  HomeScreenCubit(this._firebaseFirestore) : super(HomeScreenInitial()) {
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    emit(HomeScreenLoading());
    try {
      Stream<QuerySnapshot> postsStream = _firebaseFirestore
          .collection('posts')
          .orderBy('time', descending: true)
          .snapshots();

      postsStream.listen((snapshot) {
        emit(HomeScreenLoaded(snapshot.docs));
      }, onError: (error) {
        emit(HomeScreenError(error.toString()));
      });
    } catch (e) {
      emit(HomeScreenError(e.toString()));
    }
  }
}