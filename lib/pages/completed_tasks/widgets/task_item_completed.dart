import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taski_todo/core/ui/styles/app_text_styles.dart';

import 'package:taski_todo/models/task_model.dart';
import 'package:taski_todo/pages/home/home_cubit.dart';

class TaskItemCompleted extends StatelessWidget {
  final Task task;

  const TaskItemCompleted({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0Xfff5f7f9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: Color(0XFFC6CFDC),
            image: DecorationImage(
              image: AssetImage("assets/images/rectangle.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: ImageIcon(
            const AssetImage("assets/images/check.png"),
            color: Colors.white,
          ),
        ),
        title: Text(
          task.title,
          style: context.textStyles.textRegular,
        ),
        trailing: InkWell(
          onTap: () => context.read<TaskCubit>().deleteTask(task.id!),
          child: ImageIcon(
            const AssetImage("assets/images/delete.png"),
            size: 24,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
