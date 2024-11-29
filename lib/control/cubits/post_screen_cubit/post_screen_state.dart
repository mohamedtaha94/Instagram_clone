abstract class PostScreenState {}

class PostScreenInitial extends PostScreenState {}

class PostScreenLoading extends PostScreenState {}

class PostScreenLoaded extends PostScreenState {
  final dynamic postData;

  PostScreenLoaded(this.postData);
}

class PostScreenError extends PostScreenState {
  final String message;

  PostScreenError(this.message);
}