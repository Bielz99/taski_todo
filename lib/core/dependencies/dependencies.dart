import 'package:get_it/get_it.dart';
import 'package:taski_todo/pages/home/home_cubit.dart';
import 'package:taski_todo/repositories/task_repository/task_repository.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton<TaskRepository>(() => TaskRepository());
  getIt.registerFactory<TaskCubit>(() => TaskCubit(getIt<TaskRepository>()));
}
