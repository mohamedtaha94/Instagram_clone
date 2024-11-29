import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'explore_state.dart';

class ExploreCubit extends Cubit<ExploreState> {
  ExploreCubit() : super(ExploreInitial());

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  void loadPosts() async {
    emit(ExploreLoading());
    try {
      final postsSnapshot = await _firebaseFirestore.collection('posts').get();
      final posts = postsSnapshot.docs.map((doc) => doc.data()).toList();
      emit(ExploreShowPosts(posts));
    } catch (e) {
      emit(ExploreError('Failed to load posts: $e'));
    }
  }

  void searchUsers(String query) async {
    if (query.isEmpty) {
      loadPosts();
      return;
    }
    emit(ExploreLoading());
    try {
      final usersSnapshot = await _firebaseFirestore
          .collection('users')
          .where('username', isGreaterThanOrEqualTo: query)
          .get();
      final users = usersSnapshot.docs.map((doc) => doc.data()).toList();
      emit(ExploreShowUsers(users));
    } catch (e) {
      emit(ExploreError('Failed to search users: $e'));
    }
  }
}
