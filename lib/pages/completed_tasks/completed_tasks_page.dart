import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taski_todo/core/ui/styles/app_text_styles.dart';
import 'package:taski_todo/pages/completed_tasks/widgets/completed_tasks_header.dart';
import 'package:taski_todo/pages/completed_tasks/widgets/completed_tasks_list.dart';
import 'package:taski_todo/pages/home/home_cubit.dart';
import 'package:taski_todo/pages/home/home_state.dart';
import 'package:taski_todo/pages/widgets/taski_app_bar/taski_app_bar.dart';

class CompletedTasksPage extends StatefulWidget {
  const CompletedTasksPage({super.key});

  @override
  State<CompletedTasksPage> createState() => _CompletedTasksPageState();
}

class _CompletedTasksPageState extends State<CompletedTasksPage> {
  @override
  void initState() {
    super.initState();
    context.read<TaskCubit>().getCompletedTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TaskiAppBar(),
      body: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          if (state is TaskLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TaskLoaded) {
            final completedTasks =
                state.tasks.where((task) => task.isChecked).toList();

            if (completedTasks.isEmpty) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Column(
                  children: [
                    CompletedTasksHeader(),
                    Expanded(
                      child: Center(
                        child: Text(
                          'No completed tasks yet!',
                          style: context.textStyles.textRegular.copyWith(
                            fontSize: 18,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const CompletedTasksHeader(),
                  const SizedBox(height: 12),
                  Expanded(
                    child: CompletedTasksList(completedTasks: completedTasks),
                  ),
                ],
              ),
            );
          } else if (state is TaskError) {
            return Center(
              child: Text(state.message),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
