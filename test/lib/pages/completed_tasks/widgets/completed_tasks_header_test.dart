import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taski_todo/pages/completed_tasks/widgets/completed_tasks_header.dart';
import 'package:taski_todo/pages/home/home_cubit.dart';
import 'package:taski_todo/pages/home/home_state.dart';

class MockTaskCubit extends Mock implements TaskCubit {}

void main() {
  late MockTaskCubit mockTaskCubit;

  setUp(() {
    mockTaskCubit = MockTaskCubit();

    whenListen(
      mockTaskCubit,
      Stream.value(TaskLoaded([])),
      initialState: TaskLoaded([]),
    );

    when(() => mockTaskCubit.deleteAllTasks()).thenAnswer((_) async {});
  });

  Future<void> pumpTestWidget(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: BlocProvider<TaskCubit>.value(
            value: mockTaskCubit,
            child: const CompletedTasksHeader(),
          ),
        ),
      ),
    );
  }

  group('CompletedTasksHeader Widget Tests', () {
    testWidgets('Should display the title "Completed Tasks"', (tester) async {
      await pumpTestWidget(tester);
      expect(find.text('Completed Tasks'), findsOneWidget);
    });

    testWidgets('Should display the "Delete all" button', (tester) async {
      await pumpTestWidget(tester);
      expect(find.text('Delete all'), findsOneWidget);
    });

    testWidgets('Should call deleteAllTasks when "Delete all" is tapped',
        (tester) async {
      await pumpTestWidget(tester);

      await tester.tap(find.text('Delete all'));
      await tester.pump();

      verify(() => mockTaskCubit.deleteAllTasks()).called(1);
    });
  });
}
