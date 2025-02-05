import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taski_todo/models/task_model.dart';
import 'package:taski_todo/pages/home/home_cubit.dart';
import 'package:taski_todo/pages/home/home_state.dart';
import 'package:taski_todo/pages/home/widgets/no_tasks_widget.dart';
import 'package:taski_todo/pages/home/widgets/task_list.dart';
import 'package:taski_todo/pages/home/widgets/task_list_section.dart';

class MockTaskCubit extends Mock implements TaskCubit {}

void main() {
  late MockTaskCubit mockTaskCubit;
  late TextEditingController titleController;
  late TextEditingController noteController;

  setUp(() {
    mockTaskCubit = MockTaskCubit();
    titleController = TextEditingController();
    noteController = TextEditingController();
  });

  tearDown(() {
    titleController.dispose();
    noteController.dispose();
  });
  void configureMockCubit(TaskState initialState) {
    whenListen(
      mockTaskCubit,
      Stream.value(initialState),
      initialState: initialState,
    );
  }

  group('TaskListSection', () {
    testWidgets(
        'should display CircularProgressIndicator when state is TaskLoading',
        (WidgetTester tester) async {
      configureMockCubit(TaskLoading());

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<TaskCubit>.value(
              value: mockTaskCubit,
              child: TaskListSection(
                taskCubit: mockTaskCubit,
                titleController: titleController,
                noteController: noteController,
              ),
            ),
          ),
        ),
      );

      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should display TaskList when state is TaskLoaded with tasks',
        (WidgetTester tester) async {
      final tasks = [
        Task(title: 'Task 1', subtitle: 'Subtitle 1'),
        Task(title: 'Task 2', subtitle: 'Subtitle 2'),
      ];
      configureMockCubit(TaskLoaded(tasks));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<TaskCubit>.value(
              value: mockTaskCubit,
              child: TaskListSection(
                taskCubit: mockTaskCubit,
                titleController: titleController,
                noteController: noteController,
              ),
            ),
          ),
        ),
      );

      await tester.pump();

      expect(find.byType(TaskList), findsOneWidget);
    });

    testWidgets(
        'should display NoTasksWidget when state is TaskLoaded with no tasks',
        (WidgetTester tester) async {
      configureMockCubit(TaskLoaded([]));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<TaskCubit>.value(
              value: mockTaskCubit,
              child: TaskListSection(
                taskCubit: mockTaskCubit,
                titleController: titleController,
                noteController: noteController,
              ),
            ),
          ),
        ),
      );

      await tester.pump();

      expect(find.byType(NoTasksWidget), findsOneWidget);
    });

    testWidgets('should display error message when state is TaskError',
        (WidgetTester tester) async {
      const errorMessage = 'Failed to load tasks';
      configureMockCubit(TaskError(errorMessage));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<TaskCubit>.value(
              value: mockTaskCubit,
              child: TaskListSection(
                taskCubit: mockTaskCubit,
                titleController: titleController,
                noteController: noteController,
              ),
            ),
          ),
        ),
      );

      await tester.pump();

      expect(find.text(errorMessage), findsOneWidget);
      expect(find.byType(Center), findsOneWidget);
    });
  });
}
