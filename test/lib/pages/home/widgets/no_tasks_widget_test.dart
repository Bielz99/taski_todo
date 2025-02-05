import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taski_todo/pages/home/widgets/no_tasks_widget.dart';
import 'package:taski_todo/pages/widgets/create_task_modal/create_task_modal.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  group('NoTasksWidget', () {
    late TextEditingController titleController;
    late TextEditingController noteController;

    setUp(() {
      titleController = TextEditingController();
      noteController = TextEditingController();
    });

    tearDown(() {
      titleController.dispose();
      noteController.dispose();
    });

    testWidgets('should show CreateTaskModal when "Create task" is tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NoTasksWidget(
              titleController: titleController,
              noteController: noteController,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Create task'));
      await tester.pump();
      expect(find.byType(CreateTaskModal), findsOneWidget);
    });
  });
}
