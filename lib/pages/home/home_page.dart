import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:taski_todo/pages/home/home_cubit.dart';
import 'package:taski_todo/pages/home/widgets/task_count.dart';
import 'package:taski_todo/pages/home/widgets/task_list_section.dart';
import 'package:taski_todo/pages/home/widgets/welcome_text.dart';
import 'package:taski_todo/pages/widgets/taski_app_bar/taski_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TaskCubit taskCubit = GetIt.I<TaskCubit>();
  final titleController = TextEditingController();
  final noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    taskCubit.loadTasks();
  }

  @override
  void dispose() {
    titleController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const TaskiAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const WelcomeText(username: 'John'),
            const SizedBox(height: 4),
            TaskCount(taskCubit: taskCubit),
            const SizedBox(height: 20),
            Expanded(
              child: TaskListSection(
                taskCubit: taskCubit,
                titleController: titleController,
                noteController: noteController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
