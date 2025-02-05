import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taski_todo/models/task_model.dart';
import 'package:taski_todo/pages/home/home_cubit.dart';
import 'package:taski_todo/pages/home/home_state.dart';
import 'package:taski_todo/services/task_service/task_service.dart';

class MockTaskService extends Mock implements TaskService {}

void main() {
  late TaskCubit taskCubit;
  late MockTaskService mockTaskService;

  setUp(() {
    mockTaskService = MockTaskService();
    taskCubit = TaskCubit(mockTaskService);
    registerFallbackValue(
        Task(id: 0, title: '', subtitle: '', isChecked: false));
  });

  tearDown(() {
    taskCubit.close();
  });

  group('TaskCubit', () {
    test('initial state is TaskInitial', () {
      expect(taskCubit.state, isA<TaskInitial>());
    });

    group('loadTasks', () {
      test(
          'emits TaskLoading and TaskLoaded when tasks are fetched successfully',
          () async {
        final tasks = [Task(id: 1, title: 'Task 1', subtitle: 'Subtitle 1')];
        when(() => mockTaskService.fetchTasks()).thenAnswer((_) async => tasks);

        await taskCubit.loadTasks();

        expect(taskCubit.state, isA<TaskLoaded>());
        expect((taskCubit.state as TaskLoaded).tasks, equals(tasks));
        verify(() => mockTaskService.fetchTasks()).called(1);
      });

      test('emits TaskLoading and TaskError when fetching tasks fails',
          () async {
        when(() => mockTaskService.fetchTasks())
            .thenThrow(Exception('Failed to load tasks'));

        await taskCubit.loadTasks();

        expect(taskCubit.state, isA<TaskError>());
        expect((taskCubit.state as TaskError).message,
            'Erro ao carregar tarefas: Exception: Failed to load tasks');
        verify(() => mockTaskService.fetchTasks()).called(1);
      });
    });

    group('addTask', () {
      test('emits TaskError when adding a task fails', () async {
        when(() => mockTaskService.addTask(any()))
            .thenThrow(Exception('Failed to add task'));

        await taskCubit.addTask('Task 1', 'Subtitle 1');

        expect(taskCubit.state, isA<TaskError>());
        expect((taskCubit.state as TaskError).message,
            'Erro ao adicionar tarefa: Exception: Failed to add task');
        verify(() => mockTaskService.addTask(any())).called(1);
      });
    });

    group('toggleTask', () {
      test('emits TaskLoaded with updated task when toggling a task', () async {
        final task = Task(
            id: 1, title: 'Task 1', subtitle: 'Subtitle 1', isChecked: false);
        final updatedTask = Task(
            id: 1, title: 'Task 1', subtitle: 'Subtitle 1', isChecked: true);

        when(() => mockTaskService.updateTask(any()))
            .thenAnswer((_) async => 0);
        when(() => mockTaskService.fetchTasks())
            .thenAnswer((_) async => [updatedTask]);

        taskCubit.loadTasks();

        await taskCubit.toggleTask(task);

        expect(taskCubit.state, isA<TaskLoaded>());
        expect((taskCubit.state as TaskLoaded).tasks.first.isChecked, true);
        verify(() => mockTaskService.updateTask(any())).called(1);
      });
    });

    group('deleteTask', () {
      test('emits TaskError when deleting a task fails', () async {
        when(() => mockTaskService.deleteTask(any()))
            .thenThrow(Exception('Failed to delete task'));

        await taskCubit.deleteTask(1);

        expect(taskCubit.state, isA<TaskError>());
        expect((taskCubit.state as TaskError).message,
            'Erro ao excluir tarefa: Exception: Failed to delete task');
        verify(() => mockTaskService.deleteTask(any())).called(1);
      });
    });

    group('searchTasks', () {
      test('emits TaskLoading and TaskLoaded when searching tasks successfully',
          () async {
        final tasks = [Task(id: 1, title: 'Task 1', subtitle: 'Subtitle 1')];
        when(() => mockTaskService.searchTasks(any()))
            .thenAnswer((_) async => tasks);

        await taskCubit.searchTasks('Task');

        expect(taskCubit.state, isA<TaskLoaded>());
        expect((taskCubit.state as TaskLoaded).tasks, equals(tasks));
        verify(() => mockTaskService.searchTasks('Task')).called(1);
      });
    });

    group('getCompletedTasks', () {
      test(
          'emits TaskLoading and TaskLoaded when fetching completed tasks successfully',
          () async {
        final completedTasks = [
          Task(id: 1, title: 'Task 1', subtitle: 'Subtitle 1', isChecked: true)
        ];
        when(() => mockTaskService.getCompletedTasks())
            .thenAnswer((_) async => completedTasks);

        await taskCubit.getCompletedTasks();

        expect(taskCubit.state, isA<TaskLoaded>());
        expect((taskCubit.state as TaskLoaded).tasks, equals(completedTasks));
        verify(() => mockTaskService.getCompletedTasks()).called(1);
      });
    });

    group('deleteAllTasks', () {
      test(
          'emits TaskLoading and TaskLoaded with empty list when all tasks are deleted successfully',
          () async {
        when(() => mockTaskService.deleteAllTasks()).thenAnswer((_) async => 0);

        await taskCubit.deleteAllTasks();

        expect(taskCubit.state, isA<TaskLoaded>());
        expect((taskCubit.state as TaskLoaded).tasks, isEmpty);
        verify(() => mockTaskService.deleteAllTasks()).called(1);
      });
    });
  });
}
