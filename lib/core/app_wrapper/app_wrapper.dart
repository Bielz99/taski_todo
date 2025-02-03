import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:taski_todo/pages/home/home_cubit.dart';

class AppWrapper extends StatelessWidget {
  final Widget child;

  const AppWrapper({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TaskCubit>(
      create: (context) => GetIt.I<TaskCubit>(),
      child: child,
    );
  }
}
