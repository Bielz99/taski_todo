import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taski_todo/models/task_model.dart';
import 'package:taski_todo/services/task_service/task_service.dart';

class MockTaskService extends Mock implements TaskService {}

void main() {
  late MockTaskService mockTaskService;
  late Task sampleTask;

  setUp(() {
    mockTaskService = MockTaskService();
    sampleTask = Task(id: 1, title: 'Test Task', subtitle: 'Test Subtitle');
  });

  test('Deve adicionar uma tarefa', () async {
    when(() => mockTaskService.addTask(sampleTask)).thenAnswer((_) async => 1);
    final result = await mockTaskService.addTask(sampleTask);

    expect(result, 1);
  });

  test('Deve buscar todas as tarefas', () async {
    when(() => mockTaskService.fetchTasks())
        .thenAnswer((_) async => [sampleTask]);

    final result = await mockTaskService.fetchTasks();

    expect(result, isA<List<Task>>());
    expect(result.length, 1);
    verify(() => mockTaskService.fetchTasks()).called(1);
  });

  test('Deve atualizar uma tarefa', () async {
    when(() => mockTaskService.updateTask(sampleTask))
        .thenAnswer((_) async => 1);

    final result = await mockTaskService.updateTask(sampleTask);

    expect(result, 1);
    verify(() => mockTaskService.updateTask(sampleTask)).called(1);
  });

  test('Deve deletar uma tarefa pelo ID', () async {
    when(() => mockTaskService.deleteTask(1)).thenAnswer((_) async => 1);

    final result = await mockTaskService.deleteTask(1);

    expect(result, 1);
    verify(() => mockTaskService.deleteTask(1)).called(1);
  });

  test('Deve buscar tarefas com base na pesquisa', () async {
    when(() => mockTaskService.searchTasks('Test')).thenAnswer(
      (_) async => [sampleTask],
    );

    final result = await mockTaskService.searchTasks('Test');

    expect(result, isA<List<Task>>());
    expect(result.length, 1);
    expect(result.first.title, 'Test Task');
    verify(() => mockTaskService.searchTasks('Test')).called(1);
  });

  test('Deve buscar tarefas concluídas', () async {
    when(() => mockTaskService.getCompletedTasks())
        .thenAnswer((_) async => [sampleTask]);

    final result = await mockTaskService.getCompletedTasks();

    expect(result, isA<List<Task>>());
    expect(result.length, 1);
    verify(() => mockTaskService.getCompletedTasks()).called(1);
  });

  test('Deve buscar tarefas pendentes', () async {
    when(() => mockTaskService.getPendingTasks())
        .thenAnswer((_) async => [sampleTask]);

    final result = await mockTaskService.getPendingTasks();

    expect(result, isA<List<Task>>());
    expect(result.length, 1);
    verify(() => mockTaskService.getPendingTasks()).called(1);
  });

  test('Deve deletar todas as tarefas', () async {
    when(() => mockTaskService.deleteAllTasks()).thenAnswer((_) async => 1);

    final result = await mockTaskService.deleteAllTasks();

    expect(result, 1);
    verify(() => mockTaskService.deleteAllTasks()).called(1);
  });
}
