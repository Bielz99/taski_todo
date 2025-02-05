import 'dart:io';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taski_todo/core/dependencies/dependencies.dart';
import 'package:taski_todo/models/task_model.dart';
import 'package:taski_todo/pages/completed_tasks/completed_tasks_page.dart';
import 'package:taski_todo/pages/home/home_cubit.dart';
import 'package:taski_todo/pages/home/home_state.dart';

class MockTaskCubit extends Mock implements TaskCubit {}

void main() {
  setUpAll(() => HttpOverrides.global = null);
  late MockTaskCubit mockTaskCubit;

  setUp(() {
    init();
    mockTaskCubit = MockTaskCubit();
    when(() => mockTaskCubit.getCompletedTasks()).thenAnswer((_) async {});
  });
  tearDown(() {
    sl.reset();
  });
  void configureMockCubit(TaskState initialState) {
    whenListen(
      mockTaskCubit,
      Stream.value(initialState),
      initialState: initialState,
    );
  }

  Future<void> pumpTestWidget(WidgetTester tester, TaskCubit mockCubit) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: BlocProvider<TaskCubit>.value(
            value: mockCubit,
            child: CompletedTasksPage(),
          ),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 100));
  }

  group('CompletedTasksPage', () {
    testWidgets('Should call getCompletedTasks on initState', (tester) async {
      configureMockCubit(TaskInitial());
      await pumpTestWidget(tester, mockTaskCubit);
      verify(() => mockTaskCubit.getCompletedTasks()).called(1);
    });

    testWidgets('Should cirular progress indicator when state is TaskLoading',
        (tester) async {
      configureMockCubit(TaskLoading());
      await pumpTestWidget(tester, mockTaskCubit);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Should display tasks when state is TaskLoaded',
        (tester) async {
      final tasks = [
        Task(title: 'Task 1', subtitle: 'Subtitle 1', isChecked: true),
        Task(title: 'Task 2', subtitle: 'Subtitle 2', isChecked: true),
      ];
      configureMockCubit(TaskLoaded(tasks));
      await pumpTestWidget(tester, mockTaskCubit);
      expect(find.text('Task 1'), findsOneWidget);
      expect(find.text('Task 2'), findsOneWidget);
    });

    testWidgets('Should display error message when state is TaskError',
        (tester) async {
      configureMockCubit(TaskError('An error occurred'));
      await pumpTestWidget(tester, mockTaskCubit);
      expect(find.text('An error occurred'), findsOneWidget);
    });
    testWidgets('Should display message when no completed tasks exist',
        (tester) async {
      final tasks = [
        Task(title: 'Task 1', subtitle: 'Subtitle 1', isChecked: false),
        Task(title: 'Task 2', subtitle: 'Subtitle 2', isChecked: false),
      ];
      configureMockCubit(TaskLoaded(tasks));
      await pumpTestWidget(tester, mockTaskCubit);
      expect(find.text('No completed tasks yet!'), findsOneWidget);
    });
  });
}
