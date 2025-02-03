import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taski_todo/pages/home/home_cubit.dart';
import 'package:taski_todo/pages/home/home_state.dart';

class TaskCount extends StatelessWidget {
  final TaskCubit taskCubit;

  const TaskCount({super.key, required this.taskCubit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
      bloc: taskCubit,
      builder: (context, state) {
        if (state is TaskLoaded) {
          return Text(
            'You have ${state.tasks.length} task${state.tasks.length == 1 ? '' : 's'}.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
