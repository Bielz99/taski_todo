import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taski_todo/pages/home/home_cubit.dart'; // Importe o cubit corretamente
import 'package:taski_todo/pages/home/home_state.dart';
import 'package:taski_todo/pages/widgets/create_task_modal/create_task_modal.dart';

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
  void configureMockCubit(TaskState initialState) {
    whenListen(
      mockTaskCubit,
      Stream.value(initialState),
      initialState: initialState,
    );
  }

  Future<void> pumpTestWidget(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<TaskCubit>.value(
          value: mockTaskCubit,
          child: Scaffold(
            body: CreateTaskModal(
              titleController: titleController,
              noteController: noteController,
            ),
          ),
        ),
      ),
    );
  }

  testWidgets(
      'CreateTaskModal should show validation error when fields are empty',
      (WidgetTester tester) async {
    await pumpTestWidget(tester);

    await tester.tap(find.text('Create'));
    await tester.pump();

    expect(find.text('Title is required'), findsOneWidget);
    expect(find.text('Note is required'), findsOneWidget);
  });

  testWidgets(
    'CreateTaskModal should call addTask and close the modal on valid form submission',
    (WidgetTester tester) async {
      when(() => mockTaskCubit.addTask(any(), any())).thenAnswer((_) async {});

      titleController.text = 'New Task';
      noteController.text = 'This is a note';

      configureMockCubit(TaskInitial());
      await pumpTestWidget(tester);

      await tester.tap(find.text('Create'));
      await tester.pump();

      verify(() => mockTaskCubit.addTask('New Task', 'This is a note'))
          .called(1);

      await tester.pumpAndSettle();

      expect(find.byType(CreateTaskModal), findsNothing);
    },
  );

  testWidgets('CreateTaskModal should not call addTask if form is invalid',
      (WidgetTester tester) async {
    titleController.text = '';
    noteController.text = '';

    await pumpTestWidget(tester);

    await tester.tap(find.text('Create'));
    await tester.pump();

    verifyNever(() => mockTaskCubit.addTask(any(), any()));

    expect(find.text('Title is required'), findsOneWidget);
    expect(find.text('Note is required'), findsOneWidget);
  });
}
