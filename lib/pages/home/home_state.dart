import 'package:taski_todo/models/task_model.dart';

sealed class TaskState {}

final class TaskInitial extends TaskState {}

final class TaskLoading extends TaskState {}

final class TaskLoaded extends TaskState {
  final List<Task> tasks;
  TaskLoaded(this.tasks);
}

final class TaskError extends TaskState {
  final String message;
  TaskError(this.message);
}
