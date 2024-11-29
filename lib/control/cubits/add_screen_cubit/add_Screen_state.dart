abstract class AddScreenState {}

class AddScreenInitial extends AddScreenState {
  final int currentIndex;

  AddScreenInitial({this.currentIndex = 0});
}

class AddScreenPageChanged extends AddScreenState {
  final int currentIndex;

  AddScreenPageChanged(this.currentIndex);
}