import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taski_todo/models/task_model.dart';
import 'package:taski_todo/pages/home/home_state.dart';
import 'package:taski_todo/services/task_service/task_service.dart';

class TaskCubit extends Cubit<TaskState> {
  final TaskService _taskService;

  TaskCubit(this._taskService) : super(TaskInitial());

  Future<void> loadTasks() async {
    emit(TaskLoading());
    try {
      final tasks = await _taskService.fetchTasks();
      emit(TaskLoaded(tasks));
    } catch (e) {
      emit(TaskError('Erro ao carregar tarefas: $e'));
    }
  }

  Future<void> addTask(String title, String subtitle) async {
    try {
      final newTask = Task(title: title, subtitle: subtitle);
      await _taskService.addTask(newTask);
      await loadTasks();
    } catch (e) {
      emit(TaskError('Erro ao adicionar tarefa: $e'));
    }
  }

  Future<void> toggleTask(Task task) async {
    try {
      task.isChecked = !task.isChecked;

      await _taskService.updateTask(task);

      if (state is TaskLoaded) {
        final currentState = state as TaskLoaded;

        final updatedTasks = currentState.tasks.map((t) {
          return t.id == task.id ? task : t;
        }).toList();

        emit(TaskLoaded(updatedTasks));
      }
    } catch (e) {
      emit(TaskError('Erro ao atualizar tarefa: $e'));
    }
  }

  Future<void> deleteTask(int id) async {
    try {
      await _taskService.deleteTask(id);
      await loadTasks();
    } catch (e) {
      emit(TaskError('Erro ao excluir tarefa: $e'));
    }
  }

  Future<void> searchTasks(String query) async {
    emit(TaskLoading());
    try {
      final tasks = await _taskService.searchTasks(query);
      emit(TaskLoaded(tasks));
    } catch (e) {
      emit(TaskError('Erro ao buscar tarefas: $e'));
    }
  }

  Future<void> getCompletedTasks() async {
    emit(TaskLoading());
    try {
      final completedTasks = await _taskService.getCompletedTasks();
      emit(TaskLoaded(completedTasks));
    } catch (e) {
      emit(TaskError('Erro ao carregar tarefas concluídas: $e'));
    }
  }

  Future<void> deleteAllTasks() async {
    emit(TaskLoading());
    try {
      await _taskService.deleteAllTasks();
      await loadTasks();
      emit(TaskLoaded([]));
    } catch (e) {
      emit(TaskError(
          'Erro ao deletar todas as tarefas: $e')); // Mensagem de erro específica
    }
  }
}
