import 'package:taski_todo/models/task_model.dart';
import 'package:taski_todo/repositories/task_repository/task_repository.dart';
import 'package:taski_todo/services/task_service/task_service.dart';

class TaskServiceImpl implements TaskService {
  final TaskRepository _repository;

  TaskServiceImpl(this._repository);

  @override
  Future<int> addTask(Task task) async {
    return await _repository.insertTask(task);
  }

  @override
  Future<List<Task>> fetchTasks() async {
    return await _repository.getTasks();
  }

  @override
  Future<int> updateTask(Task task) async {
    return await _repository.updateTask(task);
  }

  @override
  Future<int> deleteTask(int id) async {
    return await _repository.deleteTask(id);
  }

  @override
  Future<List<Task>> searchTasks(String query) async {
    final tasks = await _repository.getTasks();
    return tasks
        .where((task) =>
            task.title.toLowerCase().contains(query.toLowerCase()) ||
            task.subtitle.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  @override
  Future<List<Task>> getCompletedTasks() async {
    return await _repository.getCompletedTasks();
  }

  @override
  Future<List<Task>> getPendingTasks() async {
    return await _repository.getPendingTasks();
  }

  @override
  Future<int> deleteAllTasks() async {
    return await _repository.deleteAllTasks();
  }
}
