import 'package:taski_todo/models/task_model.dart';

abstract class TaskService {
  Future<int> addTask(Task task);
  Future<List<Task>> fetchTasks();
  Future<int> updateTask(Task task);
  Future<int> deleteTask(int id);
  Future<List<Task>> searchTasks(String query);
  Future<List<Task>> getCompletedTasks();
  Future<List<Task>> getPendingTasks();
  Future<int> deleteAllTasks();
}
