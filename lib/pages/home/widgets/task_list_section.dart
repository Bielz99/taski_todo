import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taski_todo/pages/home/home_cubit.dart';
import 'package:taski_todo/pages/home/home_state.dart';
import 'package:taski_todo/pages/home/widgets/no_tasks_widget.dart';
import 'package:taski_todo/pages/home/widgets/task_list.dart';

class TaskListSection extends StatelessWidget {
  final TaskCubit taskCubit;
  final TextEditingController titleController;
  final TextEditingController noteController;

  const TaskListSection({
    super.key,
    required this.taskCubit,
    required this.titleController,
    required this.noteController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
      bloc: taskCubit,
      builder: (context, state) {
        if (state is TaskLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TaskLoaded) {
          return state.tasks.isNotEmpty
              ? TaskList(tasks: state.tasks)
              : NoTasksWidget(
                  titleController: titleController,
                  noteController: noteController,
                );
        } else if (state is TaskError) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
