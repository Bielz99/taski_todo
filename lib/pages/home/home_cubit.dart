import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taski_todo/models/task_model.dart';
import 'package:taski_todo/pages/home/home_state.dart';
import 'package:taski_todo/repositories/task_repository/task_repository.dart';

class TaskCubit extends Cubit<HomeState> {
  final TaskRepository taskRepository;

  TaskCubit(this.taskRepository) : super(HomeInitial());

  Future<void> loadTasks() async {
    emit(HomeLoading());
    try {
      final tasks = await taskRepository.getTasks();
      emit(HomeLoaded(tasks));
    } catch (e) {
      emit(HomeError('Failed to load tasks'));
    }
  }

  Future<void> addTask(TaskModel task) async {
    try {
      emit(HomeLoading());

      await taskRepository.addTask(task);
      final tasks = await taskRepository.getTasks();

      emit(HomeLoaded(tasks));
    } catch (e) {
      emit(HomeError('Failed to add task'));
    }
  }

  Future<void> updateTask(TaskModel task) async {
    try {
      await taskRepository.updateTask(task);
      final tasks = await taskRepository.getTasks();
      emit(HomeLoaded(tasks));
    } catch (e) {
      emit(HomeError('Failed to update task'));
    }
  }

  Future<void> deleteTask(int id) async {
    try {
      await taskRepository.deleteTask(id);
      final tasks = await taskRepository.getTasks();
      emit(HomeLoaded(tasks));
    } catch (e) {
      emit(HomeError('Failed to delete task'));
    }
  }
}
