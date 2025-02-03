import 'package:flutter/material.dart';
import 'package:taski_todo/core/app_wrapper/app_wrapper.dart';
import 'package:taski_todo/core/dependencies/dependencies.dart';
import 'package:taski_todo/core/routes/app_routes.dart';
import 'package:taski_todo/core/ui/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppWrapper(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        title: 'Taski Todo',
        initialRoute: AppRoutes.navigator,
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}
