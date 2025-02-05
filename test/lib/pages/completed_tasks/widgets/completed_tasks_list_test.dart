import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taski_todo/models/task_model.dart';
import 'package:taski_todo/pages/completed_tasks/widgets/completed_tasks_list.dart';
import 'package:taski_todo/pages/completed_tasks/widgets/task_item_completed.dart';

void main() {
  group('CompletedTasksList', () {
    testWidgets('Should display a list of completed tasks', (tester) async {
      final completedTasks = [
        Task(title: 'Task 1', subtitle: 'Subtitle 1', isChecked: true),
        Task(title: 'Task 2', subtitle: 'Subtitle 2', isChecked: true),
        Task(title: 'Task 3', subtitle: 'Subtitle 3', isChecked: true),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CompletedTasksList(completedTasks: completedTasks),
          ),
        ),
      );

      for (var task in completedTasks) {
        expect(find.text(task.title), findsOneWidget);
      }

      expect(
          find.byType(TaskItemCompleted), findsNWidgets(completedTasks.length));
    });

    testWidgets('Should display nothing when task list is empty',
        (tester) async {
      final completedTasks = <Task>[];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CompletedTasksList(completedTasks: completedTasks),
          ),
        ),
      );

      expect(find.byType(TaskItemCompleted), findsNothing);
    });
  });
}
