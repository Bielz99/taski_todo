import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taski_todo/core/ui/styles/app_text_styles.dart';
import 'package:taski_todo/models/task_model.dart';
import 'package:taski_todo/pages/home/home_cubit.dart';

class TaskList extends StatelessWidget {
  final List<Task> tasks;

  const TaskList({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return TaskItem(task: task);
      },
    );
  }
}

class TaskItem extends StatelessWidget {
  final Task task;

  const TaskItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: const Color(0Xfff5f7f9),
          borderRadius: BorderRadius.circular(16),
        ),
        child: ExpansionTile(
          shape: const Border(),
          leading: GestureDetector(
            onTap: () {
              context.read<TaskCubit>().toggleTask(task);
            },
            child: Container(
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
              child: task.isChecked
                  ? ImageIcon(
                      AssetImage("assets/images/check.png"),
                      color: Colors.white,
                    )
                  : null,
            ),
          ),
          title: Text(
            task.title,
            style: context.textStyles.textSemiBold.copyWith(
              fontSize: 16,
              color: const Color(0xff3F3D56),
              overflow: TextOverflow.ellipsis,
            ),
            maxLines: 1,
          ),
          trailing: const Icon(
            Icons.more_horiz_outlined,
            color: Color(0xffC6CFDC),
          ),
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 57.0, bottom: 15),
                child: Text(
                  task.subtitle,
                  style: context.textStyles.textSemiBold.copyWith(
                    fontSize: 14,
                    color: const Color(0xff8D9CB8),
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
