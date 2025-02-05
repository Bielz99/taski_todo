import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taski_todo/pages/home/widgets/welcome_text.dart';

void main() {
  testWidgets('WelcomeText exibe corretamente o nome de usuário',
      (WidgetTester tester) async {
    const String testUsername = 'John Doe';

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: WelcomeText(username: testUsername),
        ),
      ),
    );

    expect(
        find.byWidgetPredicate((widget) =>
            widget is RichText &&
            widget.text.toPlainText() == 'Welcome, $testUsername.'),
        findsOneWidget);
  });
}
