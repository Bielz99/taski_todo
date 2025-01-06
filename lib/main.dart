import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:taski_todo/core/dependencies/dependencies.dart';
import 'package:taski_todo/pages/home/home_cubit.dart';
import 'package:taski_todo/pages/home/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TaskCubit>(
      create: (context) => GetIt.I<TaskCubit>(),
      child: MaterialApp(
        title: 'Taski Todo',
        home: HomePage(),
      ),
    );
  }
}
