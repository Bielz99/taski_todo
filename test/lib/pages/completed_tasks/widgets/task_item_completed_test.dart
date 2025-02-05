import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taski_todo/models/task_model.dart';
import 'package:taski_todo/pages/completed_tasks/widgets/task_item_completed.dart';
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
    when(() => mockTaskCubit.deleteTask(any())).thenAnswer((_) async {});
  });

  testWidgets('Should display task title and call deleteTask on tap',
      (tester) async {
    final task =
        Task(id: 1, title: 'Completed Task', subtitle: '', isChecked: true);

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<TaskCubit>.value(
          value: mockTaskCubit,
          child: Scaffold(body: TaskItemCompleted(task: task)),
        ),
      ),
    );

    expect(find.text('Completed Task'), findsOneWidget);

    final deleteInkWell = find.byWidgetPredicate(
      (widget) =>
          widget is InkWell &&
          widget.child is ImageIcon &&
          (widget.child as ImageIcon).image ==
              const AssetImage("assets/images/delete.png"),
    );

    await tester.tap(deleteInkWell);
    await tester.pump();

    verify(() => mockTaskCubit.deleteTask(1)).called(1);
  });
}
