import 'dart:io';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taski_todo/core/dependencies/dependencies.dart';
import 'package:taski_todo/pages/completed_tasks/completed_tasks_page.dart';
import 'package:taski_todo/pages/home/home_cubit.dart';
import 'package:taski_todo/pages/home/home_page.dart';
import 'package:taski_todo/pages/search/search_page.dart';
import 'package:taski_todo/pages/navigator/bottom_navigator.dart';
import 'package:taski_todo/pages/navigator/bottom_navigator_cubit.dart';
import 'package:taski_todo/pages/navigator/bottom_navigator_state.dart';
import 'package:taski_todo/pages/widgets/create_task_modal/create_task_modal.dart';

class MockBottomNavigatorCubit extends Mock implements BottomNavigatorCubit {}

void main() {
  setUpAll(() => HttpOverrides.global = null);
  late BottomNavigatorCubit mockCubit;

  setUp(() {
    sl.reset();
    init();
    mockCubit = MockBottomNavigatorCubit();
    when(() => mockCubit.setSelectedIndex(any())).thenAnswer((_) async {});
  });

  void configureMockCubit(BottomNavigatorState initialState) {
    whenListen(
      mockCubit,
      Stream.value(initialState),
      initialState: initialState,
    );
  }

  Future<void> pumpTestWidget(
    WidgetTester tester,
    BottomNavigatorCubit mockCubit,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider<BottomNavigatorCubit>.value(value: mockCubit),
            BlocProvider<TaskCubit>(create: (_) => TaskCubit(sl())),
          ],
          child: const BottomNavigator(),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 100));
  }

  testWidgets('Deve renderizar a HomePage ao iniciar', (tester) async {
    configureMockCubit(BottomNavigatorState(selectedIndex: 0));
    await pumpTestWidget(tester, mockCubit);

    expect(find.byType(HomePage), findsOneWidget);
  });

  testWidgets('Deve renderizar a SearchPage ao selecionar índice 2',
      (tester) async {
    configureMockCubit(BottomNavigatorState(selectedIndex: 2));
    await pumpTestWidget(tester, mockCubit);

    expect(find.byType(SearchPage), findsOneWidget);
  });

  testWidgets('Deve renderizar a CompletedTasksPage ao selecionar índice 3',
      (tester) async {
    configureMockCubit(BottomNavigatorState(selectedIndex: 3));
    await pumpTestWidget(tester, mockCubit);

    expect(find.byType(CompletedTasksPage), findsOneWidget);
  });

  testWidgets('Deve exibir o modal de criação ao selecionar índice 1',
      (tester) async {
    configureMockCubit(BottomNavigatorState(selectedIndex: 0));
    await pumpTestWidget(tester, mockCubit);

    final createTabFinder = find.byWidgetPredicate(
      (widget) =>
          widget is Image &&
          (widget.image is AssetImage) &&
          (widget.image as AssetImage).assetName == 'assets/images/plus.png',
    );

    await tester.tap(createTabFinder);
    await tester.pumpAndSettle();

    expect(find.byType(CreateTaskModal), findsOneWidget);
  });
}
