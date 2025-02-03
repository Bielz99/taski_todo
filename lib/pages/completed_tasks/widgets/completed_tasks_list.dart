import 'package:flutter/material.dart';
import 'package:taski_todo/models/task_model.dart';
import 'package:taski_todo/pages/completed_tasks/widgets/task_item_completed.dart';

class CompletedTasksList extends StatelessWidget {
  final List<Task> completedTasks;

  const CompletedTasksList({super.key, required this.completedTasks});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: completedTasks.length,
      itemBuilder: (context, index) {
        final task = completedTasks[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: TaskItemCompleted(task: task),
        );
      },
    );
  }
}
