import 'package:flutter_test/flutter_test.dart';
import 'package:taski_todo/models/task_model.dart';
import 'package:taski_todo/pages/home/home_state.dart';

void main() {
  group('TaskState', () {
    test('TaskInitial should be created without parameters', () {
      final taskInitial = TaskInitial();

      expect(taskInitial, isA<TaskInitial>());
    });

    test('TaskLoading should be created without parameters', () {
      final taskLoading = TaskLoading();

      expect(taskLoading, isA<TaskLoading>());
    });

    test('TaskLoaded should be created with a list of tasks', () {
      final tasks = [
        Task(id: 1, title: 'Task 1', subtitle: 'Subtitle 1', isChecked: false),
        Task(id: 2, title: 'Task 2', subtitle: 'Subtitle 2', isChecked: true),
      ];

      final taskLoaded = TaskLoaded(tasks);

      expect(taskLoaded, isA<TaskLoaded>());
      expect(taskLoaded.tasks, tasks);
      expect(taskLoaded.tasks.length, 2);
      expect(taskLoaded.tasks[0].title, 'Task 1');
    });

    test('TaskError should be created with an error message', () {
      final errorMessage = 'An error occurred';

      final taskError = TaskError(errorMessage);

      expect(taskError, isA<TaskError>());
      expect(taskError.message, errorMessage);
    });
  });
}
