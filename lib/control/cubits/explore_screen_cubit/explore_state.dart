abstract class ExploreState {}

class ExploreInitial extends ExploreState {}

class ExploreLoading extends ExploreState {}

class ExploreShowPosts extends ExploreState {
  final List<Map<String, dynamic>> posts;

  ExploreShowPosts(this.posts);
}

class ExploreShowUsers extends ExploreState {
  final List<Map<String, dynamic>> users;

  ExploreShowUsers(this.users);
}

class ExploreError extends ExploreState {
  final String message;

  ExploreError(this.message);
}
