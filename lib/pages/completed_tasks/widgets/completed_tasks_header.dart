import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taski_todo/core/ui/styles/app_text_styles.dart';
import 'package:taski_todo/pages/home/home_cubit.dart';

class CompletedTasksHeader extends StatelessWidget {
  const CompletedTasksHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Completed Tasks',
          style: context.textStyles.textSemiBold.copyWith(fontSize: 24),
        ),
        InkWell(
          onTap: () {
            context.read<TaskCubit>().deleteAllTasks();
          },
          child: Text(
            'Delete all',
            style: context.textStyles.textRegular.copyWith(
              color: Colors.red,
              fontSize: 22,
            ),
          ),
        ),
      ],
    );
  }
}
