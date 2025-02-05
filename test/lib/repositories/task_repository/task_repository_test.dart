import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taski_todo/models/task_model.dart';
import 'package:taski_todo/repositories/task_repository/task_repository.dart';

class MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  late MockTaskRepository mockTaskRepository;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
  });

  group('TaskRepository', () {
    test('insertTask should return an int representing the inserted task id',
        () async {
      // Arrange
      final task = Task(
          id: 1,
          title: 'Test Task',
          subtitle: 'Test Subtitle',
          isChecked: false);
      when(() => mockTaskRepository.insertTask(task))
          .thenAnswer((_) async => 1);

      // Act
      final result = await mockTaskRepository.insertTask(task);

      // Assert
      expect(result, 1);
      verify(() => mockTaskRepository.insertTask(task)).called(1);
    });

    test('getTasks should return a list of tasks', () async {
      // Arrange
      final task = Task(
          id: 1,
          title: 'Test Task',
          subtitle: 'Test Subtitle',
          isChecked: false);
      when(() => mockTaskRepository.getTasks()).thenAnswer((_) async => [task]);

      // Act
      final result = await mockTaskRepository.getTasks();

      // Assert
      expect(result, isA<List<Task>>());
      expect(result.length, 1);
      expect(result[0].id, task.id);
      verify(() => mockTaskRepository.getTasks()).called(1);
    });

    test('getPendingTasks should return a list of pending tasks', () async {
      // Arrange
      final task = Task(
          id: 1,
          title: 'Test Task',
          subtitle: 'Test Subtitle',
          isChecked: false);
      when(() => mockTaskRepository.getPendingTasks())
          .thenAnswer((_) async => [task]);

      // Act
      final result = await mockTaskRepository.getPendingTasks();

      // Assert
      expect(result, isA<List<Task>>());
      expect(result.length, 1);
      expect(result[0].isChecked, false);
      verify(() => mockTaskRepository.getPendingTasks()).called(1);
    });

    test('getCompletedTasks should return a list of completed tasks', () async {
      // Arrange
      final task = Task(
          id: 1,
          title: 'Test Task',
          subtitle: 'Test Subtitle',
          isChecked: true);
      when(() => mockTaskRepository.getCompletedTasks())
          .thenAnswer((_) async => [task]);

      // Act
      final result = await mockTaskRepository.getCompletedTasks();

      // Assert
      expect(result, isA<List<Task>>());
      expect(result.length, 1);
      expect(result[0].isChecked, true);
      verify(() => mockTaskRepository.getCompletedTasks()).called(1);
    });

    test('updateTask should return the number of rows affected', () async {
      // Arrange
      final task = Task(
          id: 1,
          title: 'Updated Task',
          subtitle: 'Updated Subtitle',
          isChecked: true);
      when(() => mockTaskRepository.updateTask(task))
          .thenAnswer((_) async => 1);

      // Act
      final result = await mockTaskRepository.updateTask(task);

      // Assert
      expect(result, 1);
      verify(() => mockTaskRepository.updateTask(task)).called(1);
    });

    test('deleteTask should return the number of rows affected', () async {
      // Arrange
      const taskId = 1;
      when(() => mockTaskRepository.deleteTask(taskId))
          .thenAnswer((_) async => 1);

      // Act
      final result = await mockTaskRepository.deleteTask(taskId);

      // Assert
      expect(result, 1);
      verify(() => mockTaskRepository.deleteTask(taskId)).called(1);
    });

    test('deleteAllTasks should return the number of rows affected', () async {
      // Arrange
      when(() => mockTaskRepository.deleteAllTasks())
          .thenAnswer((_) async => 1);

      // Act
      final result = await mockTaskRepository.deleteAllTasks();

      // Assert
      expect(result, 1);
      verify(() => mockTaskRepository.deleteAllTasks()).called(1);
    });
  });
}
