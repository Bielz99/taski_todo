import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sqflite/sqflite.dart';
import 'package:taski_todo/models/task_model.dart';
import 'package:taski_todo/repositories/task_repository/task_repository_impl.dart';

// Mock da classe Database do sqflite
class MockDatabase extends Mock implements Database {}

void main() {
  late TaskRepositoryImpl repository;
  late MockDatabase mockDatabase;

  setUp(() {
    mockDatabase = MockDatabase();
    repository = TaskRepositoryImpl();
    repository.setDatabase = mockDatabase;
  });

  group('TaskRepositoryImpl', () {
    test('insertTask should insert a task and return the id', () async {
      // Arrange
      final task = Task(
          id: 1,
          title: 'Test Task',
          subtitle: 'Test Subtitle',
          isChecked: false);
      when(() => mockDatabase.insert('tasks', task.toMap()))
          .thenAnswer((_) async => 1);

      // Act
      final result = await repository.insertTask(task);

      // Assert
      expect(result, 1);
      verify(() => mockDatabase.insert('tasks', task.toMap())).called(1);
    });

    test('getTasks should return a list of tasks', () async {
      // Arrange
      final taskMap = {
        'id': 1,
        'title': 'Test Task',
        'subtitle': 'Test Subtitle',
        'isChecked': 0,
      };
      when(() => mockDatabase.query('tasks'))
          .thenAnswer((_) async => [taskMap]);

      // Act
      final result = await repository.getTasks();

      // Assert
      expect(result.length, 1);
      expect(result[0].id, 1);
      expect(result[0].title, 'Test Task');
      verify(() => mockDatabase.query('tasks')).called(1);
    });

    test('getPendingTasks should return a list of pending tasks', () async {
      // Arrange
      final taskMap = {
        'id': 1,
        'title': 'Test Task',
        'subtitle': 'Test Subtitle',
        'isChecked': 0,
      };
      when(() => mockDatabase.query(
            'tasks',
            where: 'isChecked = ?',
            whereArgs: [0],
          )).thenAnswer((_) async => [taskMap]);

      // Act
      final result = await repository.getPendingTasks();

      // Assert
      expect(result.length, 1);
      expect(result[0].isChecked, false);
      verify(() => mockDatabase.query(
            'tasks',
            where: 'isChecked = ?',
            whereArgs: [0],
          )).called(1);
    });

    test('getCompletedTasks should return a list of completed tasks', () async {
      // Arrange
      final taskMap = {
        'id': 1,
        'title': 'Test Task',
        'subtitle': 'Test Subtitle',
        'isChecked': 1,
      };
      when(() => mockDatabase.query(
            'tasks',
            where: 'isChecked = ?',
            whereArgs: [1],
          )).thenAnswer((_) async => [taskMap]);

      // Act
      final result = await repository.getCompletedTasks();

      // Assert
      expect(result.length, 1);
      expect(result[0].isChecked, true);
      verify(() => mockDatabase.query(
            'tasks',
            where: 'isChecked = ?',
            whereArgs: [1],
          )).called(1);
    });

    test('updateTask should update a task and return the number of changes',
        () async {
      // Arrange
      final task = Task(
          id: 1,
          title: 'Updated Task',
          subtitle: 'Updated Subtitle',
          isChecked: true);
      when(() => mockDatabase.update(
            'tasks',
            task.toMap(),
            where: 'id = ?',
            whereArgs: [task.id],
          )).thenAnswer((_) async => 1);

      // Act
      final result = await repository.updateTask(task);

      // Assert
      expect(result, 1);
      verify(() => mockDatabase.update(
            'tasks',
            task.toMap(),
            where: 'id = ?',
            whereArgs: [task.id],
          )).called(1);
    });

    test('deleteTask should delete a task and return the number of changes',
        () async {
      // Arrange
      const taskId = 1;
      when(() => mockDatabase.delete(
            'tasks',
            where: 'id = ?',
            whereArgs: [taskId],
          )).thenAnswer((_) async => 1);

      // Act
      final result = await repository.deleteTask(taskId);

      // Assert
      expect(result, 1);
      verify(() => mockDatabase.delete(
            'tasks',
            where: 'id = ?',
            whereArgs: [taskId],
          )).called(1);
    });

    test(
        'deleteAllTasks should delete all tasks and return the number of changes',
        () async {
      // Arrange
      when(() => mockDatabase.delete('tasks')).thenAnswer((_) async => 1);

      // Act
      final result = await repository.deleteAllTasks();

      // Assert
      expect(result, 1);
      verify(() => mockDatabase.delete('tasks')).called(1);
    });
  });
}
