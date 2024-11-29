import 'package:hii/model/usermodel.dart';

abstract class ProfileScreenState {}

class ProfileScreenInitial extends ProfileScreenState {}

class ProfileScreenLoading extends ProfileScreenState {}

class ProfileScreenLoaded extends ProfileScreenState {
  final Usermodel user;
  final List<dynamic> following;
  final int postLength;
  final bool isFollowing;

  ProfileScreenLoaded({
    required this.user,
    required this.following,
    required this.postLength,
    required this.isFollowing,
  });
}

class ProfileScreenError extends ProfileScreenState {
  final String message;

  ProfileScreenError(this.message);
}