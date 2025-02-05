import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taski_todo/models/task_model.dart';
import 'package:taski_todo/pages/home/home_cubit.dart';
import 'package:taski_todo/pages/home/home_state.dart';
import 'package:taski_todo/pages/search/search_page.dart';

class MockTaskCubit extends Mock implements TaskCubit {}

void main() {
  late MockTaskCubit mockTaskCubit;
  setUpAll(() => HttpOverrides.global = null);

  setUp(() {
    mockTaskCubit = MockTaskCubit();
    when(() => mockTaskCubit.searchTasks(any())).thenAnswer((_) async {});
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
            child: SearchPage(),
          ),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 100));
  }

  testWidgets('Should display search field and call searchTasks on input',
      (tester) async {
    configureMockCubit(TaskLoaded([]));

    await pumpTestWidget(tester, mockTaskCubit);

    // Verifica se o campo de pesquisa está na tela
    expect(find.byType(TextFormField), findsOneWidget);

    // Digita no campo de pesquisa
    await tester.enterText(find.byType(TextFormField), 'Test');
    await tester.pump();

    // Verifica se o método searchTasks foi chamado
    verify(() => mockTaskCubit.searchTasks('Test')).called(1);
  });

  testWidgets('Should display list of tasks when TaskLoaded has tasks',
      (tester) async {
    final tasks = [
      Task(id: 1, title: 'Task 1', subtitle: 'Subtitle 1', isChecked: false),
      Task(id: 2, title: 'Task 2', subtitle: 'Subtitle 2', isChecked: true),
    ];

    configureMockCubit(TaskLoaded(tasks));

    await pumpTestWidget(tester, mockTaskCubit);

    // Verifica se as tarefas são exibidas na tela
    expect(find.text('Task 1'), findsOneWidget);
    expect(find.text('Subtitle 1'), findsOneWidget);
    expect(find.text('Task 2'), findsOneWidget);
    expect(find.text('Subtitle 2'), findsOneWidget);
  });

  testWidgets('Should show "No result found." when TaskLoaded has empty list',
      (tester) async {
    configureMockCubit(TaskLoaded([]));

    await pumpTestWidget(tester, mockTaskCubit);

    // Verifica se a mensagem "No result found." é exibida
    expect(find.text('No result found.'), findsOneWidget);
  });

  testWidgets('Should show CircularProgressIndicator when TaskLoading',
      (tester) async {
    configureMockCubit(TaskLoading());

    await pumpTestWidget(tester, mockTaskCubit);

    // Verifica se o CircularProgressIndicator é exibido
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Should show error message when TaskError state occurs',
      (tester) async {
    configureMockCubit(TaskError('Error loading tasks'));

    await pumpTestWidget(tester, mockTaskCubit);

    // Verifica se a mensagem de erro é exibida
    expect(find.text('Error: Error loading tasks'), findsOneWidget);
  });
}
