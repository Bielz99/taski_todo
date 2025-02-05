import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taski_todo/core/app_wrapper/app_wrapper.dart';
import 'package:taski_todo/core/dependencies/dependencies.dart'; // Certifique-se de importar o arquivo de dependências
import 'package:taski_todo/pages/home/home_cubit.dart';
import 'package:taski_todo/pages/home/home_page.dart';
import 'package:taski_todo/pages/home/widgets/task_count.dart';
import 'package:taski_todo/pages/home/widgets/task_list_section.dart';
import 'package:taski_todo/pages/home/widgets/welcome_text.dart';
import 'package:taski_todo/pages/widgets/taski_app_bar/taski_app_bar.dart';

class MockTaskCubit extends Mock implements TaskCubit {}

void main() {
  late MockTaskCubit mockTaskCubit;
  setUpAll(() => HttpOverrides.global = null);

  setUp(() {
    init();

    mockTaskCubit = MockTaskCubit();

    when(() => mockTaskCubit.loadTasks()).thenAnswer((_) async {});
  });

  tearDown(() {
    sl.reset();
  });

  testWidgets('HomePage should render correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      AppWrapper(
        child: MaterialApp(
          home: HomePage(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(TaskiAppBar), findsOneWidget);
    expect(find.byType(WelcomeText), findsOneWidget);
    expect(find.byType(TaskListSection), findsOneWidget);
    expect(find.byType(TaskCount), findsOneWidget);
  });
}
