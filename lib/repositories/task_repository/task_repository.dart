import 'package:taski_todo/models/task_model.dart';

abstract class TaskRepository {
  Future<int> insertTask(Task task);
  Future<List<Task>> getTasks();
  Future<int> updateTask(Task task);
  Future<int> deleteTask(int id);
  Future<List<Task>> getCompletedTasks();
  Future<List<Task>> getPendingTasks();
  Future<int> deleteAllTasks();
}
