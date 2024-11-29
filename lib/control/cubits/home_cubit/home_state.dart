import 'package:cloud_firestore/cloud_firestore.dart';

abstract class HomeScreenState {}

class HomeScreenInitial extends HomeScreenState {}

class HomeScreenLoading extends HomeScreenState {}

class HomeScreenLoaded extends HomeScreenState {
  final List<DocumentSnapshot> posts;

  HomeScreenLoaded(this.posts);
}

class HomeScreenError extends HomeScreenState {
  final String message;

  HomeScreenError(this.message);
}