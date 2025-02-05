import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taski_todo/models/task_model.dart';
import 'package:taski_todo/pages/home/home_cubit.dart';
import 'package:taski_todo/pages/home/home_state.dart';
import 'package:taski_todo/pages/home/widgets/task_count.dart';

// Mock do TaskCubit
class MockTaskCubit extends Mock implements TaskCubit {}

void main() {
  late MockTaskCubit mockTaskCubit;

  setUp(() {
    mockTaskCubit = MockTaskCubit();
  });

  void configureMockCubit(TaskState initialState) {
    whenListen(
      mockTaskCubit,
      Stream.value(initialState),
      initialState: initialState,
    );
  }

  group('TaskCount', () {
    testWidgets(
        'should display the correct task count when state is TaskLoaded',
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
              child: TaskCount(taskCubit: mockTaskCubit),
            ),
          ),
        ),
      );

      await tester.pump();

      expect(find.text('You have 2 tasks.'), findsOneWidget);
    });

    testWidgets('should display singular task text when there is only one task',
        (WidgetTester tester) async {
      final tasks = [
        Task(title: 'Task 1', subtitle: 'Subtitle 1'),
      ];

      configureMockCubit(TaskLoaded(tasks));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<TaskCubit>.value(
              value: mockTaskCubit,
              child: TaskCount(taskCubit: mockTaskCubit),
            ),
          ),
        ),
      );

      await tester.pump();

      expect(find.text('You have 1 task.'), findsOneWidget);
    });

    testWidgets('should display nothing when state is not TaskLoaded',
        (WidgetTester tester) async {
      configureMockCubit(TaskInitial());

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<TaskCubit>.value(
              value: mockTaskCubit,
              child: TaskCount(taskCubit: mockTaskCubit),
            ),
          ),
        ),
      );

      await tester.pump();

      expect(find.byType(Text), findsNothing);
    });
  });
}
