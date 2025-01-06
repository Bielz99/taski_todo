import 'package:taski_todo/models/task_model.dart';

sealed class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<TaskModel> tasks;

  HomeLoaded(this.tasks);
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}
